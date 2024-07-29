import os
import boto3
import requests
from loguru import logger
from filters import Filters
# Load environment variables
images_bucket = os.environ["BUCKET_NAME"]
queue_name = os.environ["FILTERS_QUEUE_NAME"]
region = os.environ["REGION"]
alb_url = os.environ["ALB_URL"]
# Initialize SQS client, S3 client resources
sqs_client = boto3.client('sqs', region_name=region)
s3 = boto3.client('s3')


def consume():
    logger.debug('Queue is running')
    while True:
        response = sqs_client.receive_message(QueueUrl=queue_name, MaxNumberOfMessages=1, WaitTimeSeconds=5)
        if 'Messages' in response:
            message_body = response['Messages'][0]['Body']
            receipt_handle = response['Messages'][0]['ReceiptHandle']
            prediction_id = response['Messages'][0]['MessageId']

            logger.info(f'Raw message body: {message_body}')

            try:

                # Split the message body by commas and extract the relevant fields
                chat_id, photo_caption, full_s3_path, img_name = message_body.split(', ')
            except ValueError as e:
                logger.error(f"Error parsing message body: {e}")
                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                continue

            logger.info(f'Prediction: {prediction_id}. Start processing')

            if not img_name or not chat_id or not full_s3_path:
                logger.error('Invalid message format: chat_id, file_name, or s3_key missing')
                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                continue

            logger.info(f'chat_id: {chat_id}')
            logger.info(f'photo_caption: {photo_caption}')
            logger.info(f'full_s3_path: {full_s3_path}')
            logger.info(f'img_name: {img_name}')

            s3.download_file(images_bucket, full_s3_path, img_name)
            logger.info(f'Download the photo: {img_name} successfully')

            # Create a Filters object and process the image
            filters = Filters(photo_caption, img_name)
            processed_img_path, filter_name = filters.image_processing()

            logger.info(f'Processed image path: {processed_img_path}, Filter applied: {filter_name}')

            s3_directory = 'filtered_photos/'
            full_name_s3 = str(s3_directory) + str(processed_img_path)
            s3.upload_file(processed_img_path, images_bucket, full_name_s3)

            logger.info(f'Uploaded photo to s3 successfully: {full_name_s3}')
            logger.debug(f'processed_img_path: {processed_img_path}')
            # TODO send a request to the ALB with the relevant details
            if not alb_url:
                raise ValueError("ALB_URL environment variable is not set.")

            try:
                params = {
                    "full_s3_path": str(full_name_s3),
                    "processed_img_path": str(processed_img_path),
                    "chat_id": str(chat_id)
                }

                logger.info(f"{alb_url}/results_filter?predictionId={prediction_id}")

                # perform a GET request to Polybot to /results endpoint
                response = requests.post(f"{alb_url}/results_filter?predictionId={prediction_id}", json=params)
                print(response.text)

                logger.info(f"Sending POST request to {alb_url} with params: {params}")

                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                logger.info('Deleted message from the queue')

            except Exception as e:
                logger.error(f'Error processing message: {str(e)}')
                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                logger.info('Deleted message from the queue')


if __name__ == "__main__":
    consume()
