import json

import flask
from flask import request, jsonify
import os
from bot import ObjectDetectionBot
from get_secrets import GetSecrets
import boto3

app = flask.Flask(__name__)

# TODO load TELEGRAM_TOKEN value from Secret Manager
# Create an instance of GetSecrets
secrets_loader = GetSecrets()

# Retrieve TELEGRAM_TOKEN from Secrets Manager
TELEGRAM_TOKEN = secrets_loader.get_secret()

TELEGRAM_APP_URL = os.getenv('TELEGRAM_APP_URL')
region_name = os.getenv('REGION_NAME')
DYNAMODB_TABLE_NAME = os.getenv('DYNAMODB_TABLE_NAME')

@app.route('/', methods=['GET'])
def index():
    return 'Ok'


@app.route(f'/{TELEGRAM_TOKEN}/', methods=['POST'])
def webhook():
    req = request.get_json()
    bot.handle_message(req['message'])
    return 'Ok'


@app.route(f'/results', methods=['POST'])
def results():
    prediction_id = request.args.get('predictionId')

    # TODO use the prediction_id to retrieve results from DynamoDB and send to the end-user

    try:
        dynamodb = boto3.resource('dynamodb', region_name)
        table = dynamodb.Table(DYNAMODB_TABLE_NAME)
    except Exception as e:
        return jsonify({'error': f'Error connecting to DynamoDB: {str(e)}'}), 500

    # Get the predictionId from the request
    prediction_id = request.args.get('predictionId')
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


@app.route(f'/loadTest/', methods=['POST'])
def load_test():
    req = request.get_json()
    bot.handle_message(req['message'])
    return 'Ok'


# Route for health checks
@app.route('/health_checks/', methods=['GET'])
def health_checks():
    return 200


if __name__ == "__main__":
    bot = ObjectDetectionBot(TELEGRAM_TOKEN, TELEGRAM_APP_URL)

    app.run(host='0.0.0.0', port=8443)
