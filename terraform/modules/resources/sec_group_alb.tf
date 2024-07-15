##########################
# Security group for ALB #
##########################
resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg-"
  vpc_id      = var.main_vpc_id

  ingress {
    from_port   = var.polybot_port
    to_port     = var.polybot_port
    protocol    = "tcp"
    cidr_blocks = [var.first_telegram_cidr, var.second_telegram_cidr]
  }

  ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = var.polybot_port
    to_port     = var.polybot_port
    protocol    = "tcp"
    cidr_blocks = [var.main_vpc_cidr]
  }

  tags = {
    Name = "${var.owner}-alb-sg-${var.project}"
    Terraform = "true"
  }
}

