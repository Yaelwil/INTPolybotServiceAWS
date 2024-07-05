###########################################
# Security group for Polybot EC2 instances #
###########################################
resource "aws_security_group" "polybot_sg" {
  name_prefix = "polybot-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.polybot_port
    to_port         = var.polybot_port
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"] # Restricts inbound traffic to come only from ALB
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  # Allowing SSH access from anywhere (consider restricting further)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.owner}-polybot-sg-${var.project}"
    Terraform = "true"
  }
}
