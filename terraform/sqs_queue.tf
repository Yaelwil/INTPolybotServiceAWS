####################
# Yolov5 SQS queue #
####################

resource "aws_sqs_queue" "yolov5-sqs-queue" {
  name       = "${var.owner}-yolov5-sqs-queue-${var.project}"
  fifo_queue = true
  content_based_deduplication = false # the messages will be enqueued as separate messages.

  tags = {
    Name      = "${var.owner}-yolov5-sqs-queue-${var.project}"
    Terraform = "true"
  }
}

#####################
# filters SQS queue #
#####################

resource "aws_sqs_queue" "filters-sqs-queue" {
  name       = "${var.owner}-filters-sqs-queue-${var.project}"
  fifo_queue = true
  content_based_deduplication = false # the messages will be enqueued as separate messages.

  tags = {
    Name      = "${var.owner}-filters-sqs-queue-${var.project}"
    Terraform = "true"
  }
}