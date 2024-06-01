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

###########################################
# Security group for Yolov5 EC2 instances #
###########################################

resource "aws_security_group" "yolov5_sg" {
  name_prefix = "yolov5-sg-"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.yolov5_port
    to_port     = var.yolov5_port
    protocol    = "tcp"
    #TODO change the security group to the auto scaling SG
    security_groups = [] # restricts inbound traffic to only come from the ASG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.owner}-yolov5-sg-${var.project}"
    Terraform = "true"
  }
}