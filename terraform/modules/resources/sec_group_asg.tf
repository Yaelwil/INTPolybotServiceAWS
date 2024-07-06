##########################################
# Security group for Auto Scaling Group #
##########################################

resource "aws_security_group" "asg_sg" {
  name_prefix = "asg-sg-"
  vpc_id      = var.main_vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
#     security_groups = [] # restricts inbound traffic to only come from the ALB
  }
    ingress {
      from_port       = 8080
      to_port         = 8080
      protocol        = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.owner}-asg-sg-${var.project}"
    Terraform = "true"
  }
}