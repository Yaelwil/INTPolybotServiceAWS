import telebot
from loguru import logger
import os
import time
from telebot.types import InputFile
from s3_upload import Detect_Filters


class Bot:

    def __init__(self, token, telegram_chat_url):
        # create a new instance of the TeleBot class.
        # all communication with Telegram servers are done using self.telegram_bot_client
        self.telegram_bot_client = telebot.TeleBot(token)

        # remove any existing webhooks configured in Telegram servers
        self.telegram_bot_client.remove_webhook()
        time.sleep(0.5)

        # set the webhook URL
        self.telegram_bot_client.set_webhook(url=f'{telegram_chat_url}/{token}/', timeout=60)

        logger.info(f'Telegram Bot information\n\n{self.telegram_bot_client.get_me()}')

    def send_text(self, chat_id, text):
        self.telegram_bot_client.send_message(chat_id, text)

    def send_text_with_quote(self, chat_id, text, quoted_msg_id):
        self.telegram_bot_client.send_message(chat_id, text, reply_to_message_id=quoted_msg_id)

    def is_current_msg_photo(self, msg):
        return 'photo' in msg

    def download_user_photo(self, msg):
        """
        Downloads the photos that sent to the Bot to `photos` directory (should be existed)
        :return:
        """
        if not self.is_current_msg_photo(msg):
            raise RuntimeError(f'Message content of type \'photo\' expected')

        file_info = self.telegram_bot_client.get_file(msg['photo'][-1]['file_id'])
        data = self.telegram_bot_client.download_file(file_info.file_path)
        folder_name = file_info.file_path.split('/')[0]

        if not os.path.exists(folder_name):
            os.makedirs(folder_name)

        with open(file_info.file_path, 'wb') as photo:
            photo.write(data)

        return file_info.file_path

    def send_photo(self, chat_id, img_path):
        if not os.path.exists(img_path):
            raise RuntimeError("Image path doesn't exist")

        self.telegram_bot_client.send_photo(
            chat_id,
            InputFile(img_path)
        )

    def handle_message(self, msg):
        """Bot Main message handler"""
        logger.info(f'Incoming message: {msg}')
        self.send_text(msg['chat']['id'], f'Your original message: {msg["text"]}')


class ObjectDetectionBot(Bot):
    def handle_message(self, msg):
        logger.info(f'Incoming message: {msg}')

        if self.is_current_msg_photo(msg):
            photo_path = self.download_user_photo(msg)

        def upload_to_s3():
            # Rename the photo with timestamp
            try:
                detect_filters_instance = Detect_Filters(photo_path)
                # Rename the photo with timestamp
                new_photo_path, new_file_name = detect_filters_instance.rename_photo_with_timestamp(photo_path)
            except Exception as e:
                logger.error(f"Error renaming photo: {e}")
                raise

            if new_photo_path and new_file_name:

                # Upload the photo to S3 and make sure the directory exists
                try:
                    detect_filters_instance = Detect_Filters(new_photo_path)
                    s3_key = detect_filters_instance.upload_photo_to_s3(new_photo_path)
                except Exception as e:
                    logger.error(f"Error uploading photo to S3: {e}")
                    return None

                if s3_key:
                    return

                else:
                    logger.error("Error uploading photo to S3.")
            else:
                logger.error("Error renaming photo.")

            # TODO upload the photo to S3
        upload_to_s3()


            # TODO send a job to the SQS queue
            # TODO send message to the Telegram end-user (e.g. Your image is being processed. Please wait...)
