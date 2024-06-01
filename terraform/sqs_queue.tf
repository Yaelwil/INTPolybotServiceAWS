# resource "aws_sqs_queue" "sqs-queue" {
#   name       = "${var.owner}-sqs-queue-${var.project}"
#   fifo_queue = true
#   content_based_deduplication = false # the messages will be enqueued as separate messages.
#
#   tags = {
#     Name      = "${var.owner}-sqs-queue-${var.project}"
#     Terraform = "true"
#   }
# }
