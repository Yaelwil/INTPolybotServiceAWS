output "my_key_pair" {
  description = "SSH key"
  value       = aws_key_pair.my_key_pair.key_name
}

output "main_vpc_cidr" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}

output "region" {
  description = "region"
  value       = var.region
}

output "main_vpc_id" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_id
}

output "polybot_port" {
  description = "polybot_port"
  value       = var.polybot_port
}
output "first_telegram_cidr" {
  description = "first_telegram_cidr"
  value       = var.first_telegram_cidr
}
output "second_telegram_cidr" {
  description = "second_telegram_cidr"
  value       = var.second_telegram_cidr
}

output "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
  value       = var.ubuntu_ami
}

output "public_subnet_1" {
  description = "public_subnet_1"
  value       = var.public_subnet_1
}

output "public_subnet_2" {
  description = "public_subnet_2"
  value       = var.public_subnet_2
}

output "public_subnet_1_id" {
  description = "public_subnet_1_id"
  value       = var.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "public_subnet_2_id"
  value       = var.public_subnet_2_id
}

output "bucket_arn" {
  description = "bucket_arn"
  value       = aws_s3_bucket.project_bucket.arn
}

output "dynamodb_table_arn" {
  description = "dynamodb_table_arn"
  value       = aws_dynamodb_table.dynamodb-table.arn
}

output "yolov5_sqs_queue_arn" {
  description = "yolov5_sqs_queue_arn"
  value       = aws_sqs_queue.yolov5_sqs_queue.arn
}

output "filters_sqs_queue_arn" {
  description = "filters_sqs_queue_arn"
  value       = aws_sqs_queue.filters_sqs_queue.arn
}

output key_pair_name {
  description = "public key name"
  value = aws_key_pair.my_key_pair.key_name
}


output "instance_ids" {
  description = "List of instance IDs to register in the target group"
  value = var.instance_ids
}