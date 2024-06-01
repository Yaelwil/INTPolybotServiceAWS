resource "aws_s3_bucket" "project_bucket" {
  bucket            = "${var.owner}-bucket-${var.project}"
  # aws_s3_bucket_acl = "private"
  acl    = "private"  # Specify the ACL here

  tags = {
    Name      = "${var.owner}-bucket-${var.project}"
    Terraform = "true"
  }
}
