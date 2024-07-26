#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable docker
sudo systemctl start docker

# Navigate to the directory containing Terraform configuration if necessary
cd ../..

# Fetch Terraform outputs
AWS_REGION=$(terraform output -raw region)
BUCKET_NAME=$(terraform output -raw bucket_name)
ALB_URL=$(terraform output -raw alb_url)
DYNAMODB_TABLE_NAME=$(terraform output -raw dynamodb_table_name)
FILTERS_QUEUE_URL=$(terraform output -raw filters_queue_url)
YOLO_QUEUE_URL=$(terraform output -raw yolo_queue_url)

# Create or update .env file
cat <<EOF > .env
AWS_REGION=$AWS_REGION
BUCKET_NAME=$BUCKET_NAME
ALB_URL=$ALB_URL
DYNAMODB_TABLE_NAME=$DYNAMODB_TABLE_NAME
FILTERS_QUEUE_URL=$FILTERS_QUEUE_URL
YOLO_QUEUE_URL=$YOLO_QUEUE_URL
EOF

# Fetch tags using Docker Hub API and select the latest tag
IMAGE_NAME="yaeli1/polybot"
PAGE_SIZE=100
LATEST_TAG=$(curl -s "https://hub.docker.com/v2/repositories/$IMAGE_NAME/tags/?page_size=$PAGE_SIZE" | \
    jq -r '.results | map(.name) | max_by(. | split(".") | map(tonumber))')

sudo docker pull yaeli1/polybot:${LATEST_TAG}
sudo docker run -d -p 8443:8443 --name polybot --env-file .env ${IMAGE_NAME}:${LATEST_TAG}