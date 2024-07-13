####################
# Yolov5 SQS queue #
####################

resource "aws_sqs_queue" "yolov5_sqs_queue" {
  name       = "${var.owner}-yolov5-sqs-queue-${var.project}.fifo"
  fifo_queue = true
  content_based_deduplication = true

  tags = {
    Name      = "${var.owner}-yolov5-sqs-queue-${var.project}"
    Terraform = "true"
  }
}

#####################
# filters SQS queue #
#####################

resource "aws_sqs_queue" "filters_sqs_queue" {
  name       = "${var.owner}-filters-sqs-queue-${var.project}.fifo"
  fifo_queue = true
  content_based_deduplication = true

  tags = {
    Name      = "${var.owner}-filters-sqs-queue-${var.project}.fifo"
    Terraform = "true"
  }
}