import time
import os
import boto3
from loguru import logger
from filters import Filters
from img_proc import Img

# Load environment variables
images_bucket = os.environ["BUCKET_NAME"]
queue_name = os.environ["FILTERS_QUEUE_NAME"]
region = os.environ["REGION"]

# Initialize SQS client, S3 client resources
sqs_client = boto3.client('sqs', region_name=region)
s3_client = boto3.client('s3')

def consume():
    while True:
        response = sqs_client.receive_message(QueueUrl=queue_name, MaxNumberOfMessages=1, WaitTimeSeconds=5)
        if 'Messages' in response:
            message = response['Messages'][0]
            prediction_id = message['MessageId']
            chat_id = response['MessageId']['Body'][1]
            # photo_caption = message['photo_caption']
            # s3_key = message['s3_key']
            # file_name = message['file_name']

            # Print keys present in the message
            logger.info(f'Keys present in the message: {message.keys()}')
            logger.info(f'prediction_id: {prediction_id}')
            logger.info(f'chat_id: {chat_id}')



            # logger.info(f'message: {message}')
            # logger.info(f'prediction_id: {prediction_id}')
            # logger.info(f'chat_id: {chat_id}')
            # logger.info(f'photo_caption: {photo_caption}')
            # logger.info(f's3_key: {s3_key}')
            # logger.info(f'file_name: {file_name}')

            # try:
            #     # Extract message body fields
            #     chat_id, photo_caption, s3_key, file_name = message['Body'].split(', ')
            #     logger.info(f'Received message: Prediction ID: {prediction_id}, Chat ID: {chat_id}, Caption: {photo_caption}, Image: {img_name}')
            #
            # except ValueError as e:
            #     logger.error(f"Error parsing message body: {e}")
            #
            # except Exception as e:
            #     logger.error(f"Error processing message: {e}")
            #     continue

            # # Delete processed message from SQS queue
            # sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
            # logger.info(f'Deleted message from SQS queue. Prediction ID: {prediction_id}')

        # else:
        #     logger.info('No messages received')
        # time.sleep(1)

if __name__ == "__main__":
    consume()
