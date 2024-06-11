import boto3
import logging
import os
import json

from botocore.exceptions import ClientError

region_name = os.getenv('eu-west-2')

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)  # Configures logging to output to the console


class GetSecrets:
    def get_secret(self):

        secret_name = "TELEGRAM_TOKEN"

        # Create a Secrets Manager client
        session = boto3.session.Session()
        client = session.client(
            service_name='secretsmanager',
            region_name=region_name
        )

        try:
            get_secret_value_response = client.get_secret_value(
                SecretId=secret_name
            )
        except ClientError as e:
            # For a list of exceptions thrown, see
            # https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
            raise e

        secret = get_secret_value_response['SecretString']

        return json.loads(secret)
