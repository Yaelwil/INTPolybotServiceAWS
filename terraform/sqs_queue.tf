####################
# Yolov5 SQS queue #
####################

resource "aws_sqs_queue" "yolov5_sqs_queue" {
  name       = "${var.owner}_yolov5_sqs_queue_${var.project}.fifo"
  fifo_queue = true
  content_based_deduplication = false # the messages will be enqueued as separate messages.

  tags = {
    Name      = "${var.owner}_yolov5_sqs_queue_${var.project}"
    Terraform = "true"
  }
}

#####################
# filters SQS queue #
#####################

resource "aws_sqs_queue" "filters_sqs_queue" {
  name       = "${var.owner}_filters_sqs_queue_-${var.project}.fifo"
  fifo_queue = true
  content_based_deduplication = false # the messages will be enqueued as separate messages.

  tags = {
    Name      = "${var.owner}_filters_sqs_queue_${var.project}"
    Terraform = "true"
  }
}