resource "aws_s3_bucket" "project_bucket" {
  bucket = "${var.owner}-bucket-${var.project}"
  acl    = "private"  # Specify the ACL directly here

  tags = {
    Name      = "${var.owner}-bucket-${var.project}"
    Terraform = "true"
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.project_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


