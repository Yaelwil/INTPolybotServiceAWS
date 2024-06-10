import boto3
import logging

logger = logging.getLogger(__name__)


class sqs_queue:
    def send_sqs_queue(self, photo_caption):
    # Initialize the SQS client
    sqs_client = boto3.client('sqs', region_name='eu-west-2')

    # Define the URLs for the SQS queues
    FILTERS_QUEUE_URL = "https://sqs.eu-west-2.amazonaws.com/019273956931/yaelwil-filters-queue-aws-project.fifo"
    YOLOV5_QUEUE_URL = "https://sqs.eu-west-2.amazonaws.com/019273956931/yaelwil-yolov5-queue-aws-project.fifo"


        try:
            if any(filter in photo_caption for filter in ['blur', 'contour', 'rotate', 'salt and pepper', 'segment', 'random color']):
                queue_url = FILTERS_QUEUE_URL
            elif 'predict' in photo_caption:
                queue_url = YOLOV5_QUEUE_URL
            else:
                logger.info("No matching filter found in the photo caption.")
                return

            # Send the message to the SQS queue
            response = sqs_client.send_message(
                QueueUrl=queue_url,
                MessageBody=photo_caption,
                MessageGroupId='default'  # FIFO queues require a MessageGroupId
            )

            logger.info(f"Message sent to SQS queue {queue_url} with MessageId: {response['MessageId']}")

        except Exception as e:
            logger.error(f"Error sending message to SQS queue: {e}")
