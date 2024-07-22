#############################
# Application Load Balancer #
#############################

resource "aws_lb" "main-alb" {
  name               = "${var.owner}-alb-${var.project}"
  internal           = false # ALB can accept incoming requests from the public internet.
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]

  tags = {
    Name      = "${var.owner}-alb-${var.project}"
    Terraform = "true"
  }
}

################
# Target group #
################

resource "aws_lb_target_group" "polybot_tg" {
  name        = "${var.owner}-tg-${var.project}"
  port        = var.polybot_port
  protocol    = "HTTP" # Specifies the protocol used for routing traffic to the target instances.
  vpc_id      = var.main_vpc_id
  target_type = "instance" # Specifies the type of targets registered with this target group.

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5 # in seconds
    interval            = 30 # in seconds
    path                = "/health_checks/"
    matcher             = "200" # HTTP response status code that is considered healthy
  }

  tags = {
    Name = "${var.owner}-tg-${var.project}"
    Terraform = "true"
  }
}

###################################
# Target group Polybot attachment #
###################################

resource "aws_lb_target_group_attachment" "polybot_tg_attachment" {
  for_each          = { for idx, id in tolist(var.instance_ids) : idx => id }
  target_group_arn  = aws_lb_target_group.polybot_tg.arn
  target_id         = each.value
  port              = var.polybot_port
}

#############
# Listeners #
#############

resource "aws_acm_certificate" "self_signed" {
  private_key = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
  tags = {
    Name = "self-signed-cert"
  }
}


resource "aws_lb_listener" "listener_8443" {
  load_balancer_arn = aws_lb.main-alb.arn # ARN of the ALB to which this listener is attached
  port            = var.polybot_port
  protocol = "HTTPS" # protocol used by the listener
  ssl_policy      = "ELBSecurityPolicy-2016-08" # The SSL policy refers to a predefined SSL policy provided by AWS
  # TODO add the ACCOUNT_ID AND ARN of the SSL/TLS certificate used for encrypting connections to the listener
#   certificate_arn   = data.aws_acm_certificate.example.arn
  certificate_arn   =aws_acm_certificate.self_signed.arn

  default_action {
    type = "forward" # matching requests should be forwarded to a target group.
    target_group_arn = aws_lb_target_group.polybot_tg.arn
  }

  tags = {
    Name      = "${var.owner}-listener-${var.project}"
    Terraform = "true"
    }
}

resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.main-alb.arn # ARN of the ALB to which this listener is attached
  port            = 80
  protocol = "HTTP" # protocol used by the listener

  default_action {
    type = "forward" # matching requests should be forwarded to a target group.
    target_group_arn = aws_lb_target_group.polybot_tg.arn
  }

  tags = {
    Name      = "${var.owner}-listener-${var.project}"
    Terraform = "true"
    }
}