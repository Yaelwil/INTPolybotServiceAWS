import json
import time
from pathlib import Path
import boto3
import requests
from detect import run
import uuid
import yaml
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

images_bucket = "yaelwil-bucket-aws-project"
queue_name = "https://sqs.eu-west-2.amazonaws.com/019273956931/yaelwil-yolov5-queue-aws-project.fifo"
region = "eu-west-2"

sqs_client = boto3.client('sqs', region_name=region)

with open("data/coco128.yaml", "r") as stream:
    names = yaml.safe_load(stream)['names']

def consume():
    while True:
        try:
            response = sqs_client.receive_message(QueueUrl=queue_name, MaxNumberOfMessages=1, WaitTimeSeconds=5)
            if 'Messages' in response:
                message_body = response['Messages'][0]['Body']
                receipt_handle = response['Messages'][0]['ReceiptHandle']
                message = json.loads(message_body)
                prediction_id = response['Messages'][0]['MessageId']
                logger.info(f'Prediction: {prediction_id}. Start processing')

                chat_id = message.get('chat_id')
                img_name = message.get('file_name')
                full_s3_path = message.get('s3_key')
                if not img_name or not chat_id or not full_s3_path:
                    logger.error('Invalid message format: chat_id or file_name missing')
                    sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                    continue

                logger.info(f'img_name received: {img_name}')
                s3_client = boto3.client('s3')
                s3_client.download_file(images_bucket, full_s3_path, img_name)

                original_img_path = img_name
                logger.info(f'Prediction: {prediction_id}/{original_img_path}. Download img completed')
                run(
                    weights='yolov5s.pt',
                    data='data/coco128.yaml',
                    source=original_img_path,
                    project='static/data',
                    name=prediction_id,
                    save_txt=True
                )

                logger.info(f'Prediction: {prediction_id}/{original_img_path}. done')

                predicted_img_path = Path(f'static/data/{prediction_id}/{original_img_path}')
                predicted_img_path.parent.mkdir(parents=True, exist_ok=True)

                unique_filename = str(uuid.uuid4()) + '.jpeg'
                s3_client.upload_file(str(predicted_img_path), images_bucket, unique_filename)

                pred_summary_path = Path(f'static/data/{prediction_id}/labels/{original_img_path.split("/")[-1].split(".")[0]}.txt')
                if pred_summary_path.exists():
                    with open(pred_summary_path) as f:
                        labels = f.read().splitlines()
                        labels = [line.split(' ') for line in labels]
                        labels = [{
                            'class': names[int(l[0])],
                            'cx': float(l[1]),
                            'cy': float(l[2]),
                            'width': float(l[3]),
                            'height': float(l[4]),
                        } for l in labels]
                        logger.info(f'Prediction: {prediction_id}/{original_img_path}. prediction summary:\n\n{labels}')
                        prediction_summary = {
                            'prediction_id': prediction_id,
                            'original_img_path': original_img_path,
                            'predicted_img_path': unique_filename,
                            'labels': labels,
                            'time': time.time()
                        }

                        dynamodb = boto3.resource('dynamodb', region_name=region)
                        table = dynamodb.Table('galgu-PolybotService-DynamoDB')
                        table.put_item(Item=prediction_summary)

                        polybot_url = 'http://polybot-url/results'
                        response = requests.get(polybot_url, params={
                            'predictionId': json.dumps({'chat_id': chat_id, 'prediction_id': prediction_id})})
                        if response.status_code == 200:
                            logger.info('GET request to Polybot /results endpoint successful')
                        else:
                            logger.error(
                                f'Error: GET request to Polybot /results endpoint failed with status code {response.status_code}')
                else:
                    logger.error(f'Prediction: {prediction_id}/{original_img_path}. prediction result not found')
                    sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                    continue

                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
        except Exception as e:
            logger.error(f'Error consuming SQS message: {e}')


if __name__ == "__main__":
    consume()
