resource "aws_lb" "main-alb" {
  name               = "${var.owner}-alb-${var.project}"
  internal           = false # ALB can accept incoming requests from the public internet.
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name      = "${var.owner}-alb-${var.project}"
    Terraform = "true"
  }
}

output "alb_dns_name" {
  value = aws_lb.main-alb.dns_name
}

resource "aws_lb_target_group" "polybot_tg" {
  name        = "${var.owner}-tg-${var.project}"
  port        = var.polybot_port
  protocol    = "HTTPS" # Specifies the protocol used for routing traffic to the target instances.
  vpc_id      = aws_vpc.main-vpc.id
  target_type = "instance" # Specifies the type of targets registered with this target group.

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5 # in seconds
    interval            = 30 # in seconds
    path                = "/health_checks"
    matcher             = "200" # HTTP response status code that is considered healthy
  }

  tags = {
    Name = "${var.owner}-tg-${var.project}"
    Terraform = "true"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.main-alb.arn # ARN of the ALB to which this listener is attached
  port            = var.polybot_port
  protocol = "HTTPS" # protocol used by the listener
  ssl_policy      = "ELBSecurityPolicy-2016-08" # The SSL policy refers to a predefined SSL policy provided by AWS
  # TODO add the ACCOUNT_ID AND ARN of the SSL/TLS certificate used for encrypting connections to the listener
  certificate_arn   = aws_acm_certificate.certificate_creation.arn

  default_action {
    type = "forward" # matching requests should be forwarded to a target group.
    target_group_arn = aws_lb_target_group.polybot_tg.arn
  }

  tags = {
    Name      = "${var.owner}-listener-${var.project}"
    Terraform = "true"
    }
}