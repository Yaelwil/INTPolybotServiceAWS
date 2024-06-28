import json
import boto3
from flask import jsonify, request
from loguru import logger


class RESULTS:
    def __init__(self, region, dynamodb_table_name, img_name):
        self.region = region
        self.dynamodb = boto3.resource('dynamodb', region_name=region)
        self.table = self.dynamodb.Table(dynamodb_table_name)
        self.s3 = boto3.client('s3')
        self.img_name = img_name


    def results_predict(self, prediction_id):

        try:
            if not prediction_id:
                return jsonify({'error': 'Missing predictionId'}), 400

            prediction_data = json.loads(prediction_id)
            chat_id = prediction_data.get("chat_id")
            if not chat_id:
                logger.info('chat_id:{chat_id}')
                logger.error('error: Invalid chat_id')

            response = self.table.get_item(Key={'predictionId': prediction_id})
            item = response.get('Item')
            if not item:
                return jsonify({'error': 'No results found for the given predictionId'}), 404

            text_results = item.get('results')  # Replace 'results' with the actual attribute name
            if not text_results:
                return jsonify({'error': 'No results found in the item'}), 404

            return jsonify({'status': 'Ok', 'prediction_id': prediction_id, 'text_results': text_results}), 200

        except json.JSONDecodeError:
            return jsonify({'error': 'Invalid predictionId format'}), 400

        except Exception as e:
            logger.error(f'Error retrieving results: {str(e)}')
            return jsonify({'error': f'Error retrieving results: {str(e)}'}), 500

    def results_filters(self, images_bucket, full_s3_path, img_name):
        prediction_id = request.args.get('predictionId')

        try:
            local_photo_path = f"/path/to/save/{img_name}"  # Replace with your local path
            self.s3.download_file(images_bucket, full_s3_path, img_name)
            logger.info(f'Successfully downloaded photo from S3: {img_name}')

            return jsonify({'status': 'Ok', 'prediction_id': prediction_id, 'local_photo_path': local_photo_path}), 200

        except Exception as e:
            logger.error(f'Error downloading photo from S3: {str(e)}')
            return jsonify({'error': f'Error downloading photo from S3: {str(e)}'}), 500