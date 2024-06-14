import json
import flask
from flask import request, jsonify
import boto3
from bot import ObjectDetectionBot
from get_secrets import get_secret
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, NoRegionError, ClientError

app = flask.Flask(__name__)

# Load TELEGRAM_TOKEN value from Secret Manager
secret_name = "TELEGRAM_TOKEN"
secret_value = get_secret(secret_name)

if secret_value:
    TELEGRAM_TOKEN = json.loads(secret_value)['TELEGRAM_TOKEN']
    print(f"Retrieved TELEGRAM_TOKEN from Secrets Manager")
else:
    print(f"Failed to retrieve secret {secret_name} from Secrets Manager")
    TELEGRAM_TOKEN = None  # Handle this case based on your application's needs

TELEGRAM_APP_URL = "yaelwil-alb-aws-project-1971553365.eu-west-2.elb.amazonaws.com"
REGION = "eu-west-2"
DYNAMODB_TABLE_NAME = "yaelwil-dynamodb-aws-project"

print(f"TELEGRAM_APP_URL: {TELEGRAM_APP_URL}")

# Initialize bot outside of __main__ block
bot = ObjectDetectionBot(TELEGRAM_TOKEN, TELEGRAM_APP_URL)


@app.route('/', methods=['GET'])
def index():
    return 'Ok'


@app.route(f'/{TELEGRAM_TOKEN}/', methods=['POST'])
def webhook():
    req = request.get_json()
    bot.handle_message(req['message'])
    return 'Ok'


@app.route('/results', methods=['POST'])
def results():
    prediction_id = request.args.get('predictionId')

    # Use the prediction_id to retrieve results from DynamoDB and send to the end-user
    try:
        dynamodb = boto3.resource('dynamodb', region_name=REGION)
        table = dynamodb.Table(DYNAMODB_TABLE_NAME)
    except Exception as e:
        return jsonify({'error': f'Error connecting to DynamoDB: {str(e)}'}), 500

    if not prediction_id:
        return jsonify({'error': 'Missing predictionId'}), 400

    # Extract chat_id from prediction_id (assuming prediction_id is a JSON string)
    try:
        prediction_data = json.loads(prediction_id)
        chat_id = prediction_data.get("chat_id")
        if not chat_id:
            return jsonify({'error': 'Invalid chat_id'}), 400
    except json.JSONDecodeError:
        return jsonify({'error': 'Invalid predictionId format'}), 400

    # Retrieve results from DynamoDB
    try:
        response = table.get_item(Key={'predictionId': prediction_id})
        item = response.get('Item')
        if not item:
            return jsonify({'error': 'No results found for the given predictionId'}), 404

        text_results = item.get('results')  # Replace 'results' with the actual attribute name
        if not text_results:
            return jsonify({'error': 'No results found in the item'}), 404
    except Exception as e:
        return jsonify({'error': f'Error retrieving results: {str(e)}'}), 500

    # Send results to the end-user via Telegram
    try:
        bot.send_text(chat_id, text_results)
    except Exception as e:
        return jsonify({'error': f'Error sending message to Telegram: {str(e)}'}), 500

    return jsonify({'status': 'Ok'}), 200


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
