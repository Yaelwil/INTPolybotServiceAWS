resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.owner}-public_key-${var.project}"
  public_key = var.public_key
}