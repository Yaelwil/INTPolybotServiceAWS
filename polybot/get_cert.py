import boto3
import os

# region_name = os.environ["REGION"]
region_name = os.environ["REGION"]


def get_cert(prefix):
    # Create a Secrets Manager client
    client = boto3.client('secretsmanager', region_name=region_name)

    try:
        # List all secrets
        response = client.list_secrets()

        # Extract the secret names that match the prefix
        matching_secrets = [
            secret['Name'] for secret in response['SecretList']
            if secret['Name'].startswith(prefix)
        ]

        # If any matching secrets are found, retrieve and return the first one
        if matching_secrets:
            secret_name = matching_secrets[0]
            secret_value = client.get_secret_value(SecretId=secret_name)
            return secret_value['SecretString']
        else:
            print(f"No secrets found with prefix {prefix}")
            return None
    except Exception as e:
        print(f"Error retrieving secrets: {str(e)}")
        return None