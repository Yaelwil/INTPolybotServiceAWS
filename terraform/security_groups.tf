##########################
# Security group for ALB #
##########################
resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg-"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.polybot_port
    to_port     = var.polybot_port
    protocol    = "tcp"
    cidr_blocks = [var.first_telegram_cidr, var.second_telegram_cidr]
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

##########################################
# Security group for Auto Scaling Group #
##########################################

resource "aws_security_group" "asg_sg" {
  name_prefix = "asg-sg-"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
#     security_groups = [] # restricts inbound traffic to only come from the ALB
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

############################################
# Security group for Polybot EC2 instances #
############################################
resource "aws_security_group" "polybot_sg" {
  name_prefix = "polybot-sg-"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.polybot_port
    to_port     = var.polybot_port
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # restricts inbound traffic to only come from the ALB
  }

    ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
       cidr_blocks = ["0.0.0.0/0"]  # Allowing SSH access from anywhere (replace with a more restricted CIDR block if necessary)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.owner}-polybot-sg-${var.project}"
    Terraform = "true"
  }
}
