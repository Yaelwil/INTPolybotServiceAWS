#############
# Main vars #
#############
output "owner" {
  description = "Owner of the infrastructure"
  value       = var.owner
}

output "project" {
  description = "project name"
  value       = var.project
}

#############
# VPC vars #
#############

output "main_vpc_cidr" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}


###############
# Bucket vars #
###############

output "bucket_arn" {
  description = "bucket_arn"
  value        = var.bucket_arn
}

#################
# DynamoDB vars #
#################

output "dynamodb_table_arn" {
  description = "dynamodb_table_arn"
  value        = var.dynamodb_table_arn
}

############
# SQS vars #
############

output "yolov5_sqs_queue_arn" {
  description = "yolov5_sqs_queue_arn"
  value        = var.yolov5_sqs_queue_arn
}

output "filters_sqs_queue_arn" {
  description = "filters_sqs_queue_arn"
  value        = var.filters_sqs_queue_arn
}

############
# SQS vars #
############

output "ec2_role_name" {
  description = "Name of the IAM role for EC2 instances"
  value       = aws_iam_role.ec2_role.name
}

output "ec2_instance_profile" {
  description = "Name of the IAM role for EC2 instances"
  value       = aws_iam_instance_profile.ec2_instance_profile.name
}
