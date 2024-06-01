resource "aws_sqs_queue" "sqs_queue" {
  name       = "${var.owner}-sqs_queue-${var.project}"
  fifo_queue = true
  content_based_deduplication = false # the messages will be enqueued as separate messages.

  tags = {
    Name      = "${var.owner}-sqs_queue-${var.project}"
    Terraform = "true"
  }
}
