resource "aws_s3_bucket" "project_bucket" {
  bucket = "${var.owner}-bucket-${var.region}-${var.project}"
  acl    = "private"

#   lifecycle {
#     prevent_destroy = true
#   }

  tags = {
    Name      = "${var.owner}-bucket-${var.region}-${var.project}"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.project_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}