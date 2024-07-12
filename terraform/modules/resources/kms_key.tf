resource "aws_kms_key" "kms_key" {
  description             = "${var.owner}-kms-key-${var.project}"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name = "${var.owner}-kms-key-${var.project}"
    Terraform = "true"
  }
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${var.owner}-kms-key-${var.project}"
  target_key_id = aws_kms_key.kms_key.key_id
}