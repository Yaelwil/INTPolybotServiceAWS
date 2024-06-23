import time
from pathlib import Path
from detect import run  # Ensure detect.py is in your working directory and contains the run function
import yaml
from loguru import logger
import os
import boto3
import requests
import json
import uuid
from img_proc import Img
from decimal import Decimal, ROUND_HALF_UP

# Load environment variables
images_bucket = os.environ["BUCKET_NAME"]
queue_name = os.environ["YOLO_QUEUE_NAME"]
region = os.environ["REGION"]
dynamodb_table_name = os.environ["DYNAMODB_TABLE_NAME"]
alb_url = os.environ["ALB_URL"]

# Initialize SQS client, bucket and DynamoDB table
sqs_client = boto3.client('sqs', region_name=region)
s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb', region_name=region)
dynamodb_table = dynamodb.Table(dynamodb_table_name)

# Load class names from coco128.yaml
with open("data/coco128.yaml", "r") as stream:
    names = yaml.safe_load(stream)['names']

def consume():
    while True:
        response = sqs_client.receive_message(QueueUrl=queue_name, MaxNumberOfMessages=1, WaitTimeSeconds=5)

        if 'Messages' in response:
            message_body = response['Messages'][0]['Body']
            receipt_handle = response['Messages'][0]['ReceiptHandle']
            prediction_id = response['Messages'][0]['MessageId']

            logger.info(f'Raw message body: {message_body}')

            try:
                # Split the message body by commas and extract the relevant fields
                chat_id, predict, full_s3_path, img_name = message_body.split(', ')
            except ValueError as e:
                logger.error(f"Error parsing message body: {e}")
                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                continue

            logger.info(f'Prediction: {prediction_id}. Start processing')

            if not img_name or not chat_id or not full_s3_path:
                logger.error('Invalid message format: chat_id, file_name, or s3_key missing')
                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)
                continue

            logger.info(f'img_name received: {img_name}')
            s3.download_file(images_bucket, full_s3_path, img_name)
            original_img_path = img_name









from img_proc import Img

class Filters:
    def __init__(self, photo_caption, img_path):
        self.photo_caption = photo_caption
        self.img_path = img_path

    def image_processing(self):
        if 'blur' in self.photo_caption:
            return self.apply_blur_filter()
        elif 'contour' in self.photo_caption:
            return self.apply_contour_filter()
        elif 'rotate' in self.photo_caption:
            return self.apply_rotate_filter()
        elif 'salt and pepper' in self.photo_caption:
            return self.apply_salt_n_pepper_filter()
        elif 'segment' in self.photo_caption:
            return self.apply_segment_filter()
        elif 'random color' in self.photo_caption:
            return self.apply_random_colors_filter()
        else:
            return None, "No valid filter found"

    def apply_blur_filter(self):
        return self.apply_filter(Img.blur, 'Blur')

    def apply_contour_filter(self):
        return self.apply_filter(Img.contour, 'Contour')

    def apply_rotate_filter(self):
        return self.apply_filter(Img.rotate, 'Rotate')

    def apply_salt_n_pepper_filter(self):
        return self.apply_filter(Img.salt_n_pepper, 'Salt and Pepper')

    def apply_segment_filter(self):
        return self.apply_filter(Img.segment, 'Segment')

    def apply_random_colors_filter(self):
        return self.apply_filter(Img.random_colors, 'Random Colors')

    def apply_filter(self, filter_func, filter_name):
        img_instance = Img(self.img_path)
        filter_func(img_instance)  # Call the provided filter function
        processed_img_path = img_instance.save_img()

        return processed_img_path, filter_name


if __name__ == "__main__":
    image_processing()
