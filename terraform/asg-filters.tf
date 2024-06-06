resource "aws_autoscaling_group" "filters_asg" {
  launch_template {
    id      = aws_launch_template.filters_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.owner}-filters-${var.project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "YOLOv5"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}