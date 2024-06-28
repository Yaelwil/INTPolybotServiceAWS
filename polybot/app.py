import json
import os
from loguru import logger
import flask
from flask import request, jsonify
import boto3
from bot import ObjectDetectionBot
from get_secrets import get_secret
from results import RESULTS
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, NoRegionError, ClientError

app = flask.Flask(__name__)

# Load TELEGRAM_TOKEN value from Secret Manager
secret_name_TELEGRAM_TOKEN = "TELEGRAM_TOKEN"
secret_name_DOMAIN_CERTIFICATE = "CERTIFICATE"
secret_value_TELEGRAM_TOKEN = get_secret(secret_name_TELEGRAM_TOKEN)
DOMAIN_CERTIFICATE = get_secret(secret_name_DOMAIN_CERTIFICATE)

if secret_value_TELEGRAM_TOKEN and DOMAIN_CERTIFICATE :
    TELEGRAM_TOKEN = json.loads(secret_value_TELEGRAM_TOKEN)['TELEGRAM_TOKEN']

    logger.info('Retrieved TELEGRAM_TOKEN and DOMAIN_CERTIFICATE from Secrets Manager')
else:
    raise ValueError("Failed to retrieve secret TELEGRAM_TOKEN and DOMAIN_CERTIFICATE from Secrets Manager")

TELEGRAM_APP_URL = os.environ["TELEGRAM_APP_URL"]
REGION = os.environ["REGION"]
DYNAMODB_TABLE_NAME = os.environ["DYNAMODB_TABLE_NAME"]
BUCKET_NAME = os.environ["BUCKET_NAME"]
alb_url = os.environ["ALB_URL"]

print(f"TELEGRAM_APP_URL: {TELEGRAM_APP_URL}")

domain_certificate_file = 'DOMAIN_CERTIFICATE.pem'

with open(domain_certificate_file, 'w') as file:
    file.write(DOMAIN_CERTIFICATE)

logger.info('Created certificate file successfully')

# Initialize bot outside of __main__ block
bot = ObjectDetectionBot(TELEGRAM_TOKEN, TELEGRAM_APP_URL, domain_certificate_file)


@app.route('/', methods=['GET'])
def index():
    return 'Ok'


@app.route(f'/{TELEGRAM_TOKEN}/', methods=['POST'])
def webhook():
    req = request.get_json()
    bot.handle_message(req['message'])
    return 'Ok'


@app.route('/results_predict', methods=['POST'])
def results_predict():
    logger.info('Received request from yolov5')

    # try:
    prediction_id = request.args.get('predictionId')

    if not prediction_id:
        return jsonify({'error': 'Missing predictionId'}), 400

    # Initialize RESULTS class
    results_handler = RESULTS(REGION, DYNAMODB_TABLE_NAME)


    # Call results_predict method from RESULTS class with prediction_id
    prediction_result = results_handler.results_predict(prediction_id)
    logger.info(f'prediction_result:{prediction_result}')

    # Extract relevant information from the prediction result
    chat_id = prediction_result.get('chat_id')
    text_results = prediction_result.get('text_results')

    # Send results to the end-user via Telegram
    try:
        bot.send_text(chat_id, text_results)
        logger.info('Successfully sent prediction results to Telegram')
    except Exception as e:
        return jsonify({'error': f'Error sending message to Telegram: {str(e)}'}), 500

    return jsonify({'status': 'Ok'}), 200

    # except Exception as e:
    #     return jsonify({'error': f'Internal Server Error: {str(e)}'}), 500


@app.route('/results_filter', methods=['POST'])
def results_filter():
    try:
        # Assuming JSON payload with necessary fields in the request body
        data = request.json
        full_s3_path = data.get('full_s3_path')
        img_name = data.get('img_name')

        if not full_s3_path or not img_name:
            return jsonify({'error': 'Missing full_s3_path or img_name'}), 400
        logger.info("received request")

        # Initialize RESULTS handler
        results_handler = RESULTS(BUCKET_NAME, full_s3_path, img_name)

        # Call results_filters method from RESULTS class with necessary parameters
        prediction_result, local_photo = results_handler.results_filters(BUCKET_NAME, full_s3_path, img_name)

        # Extract chat_id and filtered_photo from prediction_result
        chat_id = prediction_result.get('chat_id')
        filtered_photo = prediction_result.get('filtered_photo')

        # Send the filtered photo to the end-user via Telegram
        try:
            bot.send_photo(chat_id, img_path=filtered_photo)
            logger.info('Successfully sent filtered photo to Telegram')

        except Exception as e:
            logger.error(f'Error sending photo to Telegram: {str(e)}')
            return jsonify({'error': f'Error sending photo to Telegram: {str(e)}'}), 500

        return jsonify({'status': 'Ok'}), 200

    except Exception as e:
        logger.error(f'Internal Server Error: {str(e)}')
        return jsonify({'error': f'Internal Server Error: {str(e)}'}), 500


@app.route('/loadTest/', methods=['POST'])
def load_test():
    req = request.get_json()
    bot.handle_message(req['message'])
    return 'Ok'


@app.route('/health_checks/', methods=['GET'])
def health_checks():
    return 'Ok', 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8443)