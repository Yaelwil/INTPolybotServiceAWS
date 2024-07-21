resource "aws_iam_role" "ec2_role" {
  name               = "${var.owner}-ec2-role-${var.project}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.owner}-ec2-role-${var.region}-${var.project}"
    Terraform = "true"
  }
}
