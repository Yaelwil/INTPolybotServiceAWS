resource "local_file" "env_file" {
  filename = "${path.module}/.env"

  content = <<EOF
REGION=${var.aws_region}
BUCKET_NAME=${var.bucket_name}
ALB_URL=${var.alb_url}
DYNAMODB_TABLE_NAME=${var.dynamodb_table_name}
FILTERS_QUEUE_URL=${var.filters_queue_url}
YOLO_QUEUE_URL=${var.yolo_queue_url}
EOF
}