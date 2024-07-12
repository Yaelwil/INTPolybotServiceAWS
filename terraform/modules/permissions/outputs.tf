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
