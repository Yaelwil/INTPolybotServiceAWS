###########################################
# Security group for Polybot EC2 instances #
###########################################
resource "aws_security_group" "polybot_sg" {
  name = "${var.owner}-polybot-sg-${var.project}"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.polybot_port
    to_port         = var.polybot_port
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"] # TODO Restricts inbound traffic to come only from ALB
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  # Allowing SSH access from anywhere (consider restricting further)
  }

    ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  # Allowing SSH access from anywhere (consider restricting further)
  }

  ingress {
    from_port       = 80
    to_port         = 80
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
