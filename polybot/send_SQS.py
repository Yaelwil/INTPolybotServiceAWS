import boto3
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)  # Configures logging to output to the console


class SqsQueue:
    def __init__(self):
        self.sqs_client = boto3.client('sqs', region_name='eu-west-2')
        self.FILTERS_QUEUE_URL = "https://sqs.eu-west-2.amazonaws.com/019273956931/yaelwil-filters-queue-aws-project.fifo"
        self.YOLOV5_QUEUE_URL = "https://sqs.eu-west-2.amazonaws.com/019273956931/yaelwil-yolov5-queue-aws-project.fifo"

    def send_sqs_queue(self, chat_id, photo_caption, s3_key, file_name):
        try:
            queue_url = None
            if any(filter_word in photo_caption for filter_word in
                   ['blur', 'contour', 'rotate', 'salt and pepper', 'segment', 'random color']):
                queue_url = self.FILTERS_QUEUE_URL
            elif 'predict' in photo_caption:
                queue_url = self.YOLOV5_QUEUE_URL

            if queue_url:
                # Concatenate chat_id, photo_caption, s3_key into a single MessageBody string
                message_body = f"{chat_id}, {photo_caption}, {s3_key}, {file_name}"

                response = self.sqs_client.send_message(
                    QueueUrl=queue_url,
                    MessageBody=message_body,
                    MessageGroupId='default'
                )
                logger.info(f"Message sent to SQS queue {queue_url} with MessageId: {response['MessageId']}")
            else:
                logger.info("No matching filter found in the photo caption.")
        except Exception as e:
            logger.error(f"Error sending message to SQS queue: {e}")
