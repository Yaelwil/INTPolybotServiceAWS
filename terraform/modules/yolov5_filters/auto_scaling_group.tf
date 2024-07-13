##############################
# Auto Scaling Group Filters #
##############################

resource "aws_autoscaling_group" "filters_asg" {
  name = "${var.owner}-filters-${var.project}"

  launch_template {
    id      = aws_launch_template.filters_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  min_size         = var.asg_filters_min_size
  max_size         = var.asg_filters_max_size
  desired_capacity = var.asg_filters_desired_capacity

  health_check_type         = "EC2"
  health_check_grace_period = 300

#   iam_instance_profile = var.ec2_role # Reference your IAM instance profile here

  tag {
    key                 = "Name"
    value               = "${var.owner}-filters-${var.project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

#############################
# Auto Scaling Group Yolov5 #
#############################

resource "aws_autoscaling_group" "yolov5_asg" {
  name = "${var.owner}-yolov5-${var.project}"

  launch_template {
    id      = aws_launch_template.yolov5_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  min_size         = var.asg_yolov5_min_size
  max_size         = var.asg_yolov5_max_size
  desired_capacity = var.asg_yolov5_desired_capacity

  health_check_type         = "EC2"
  health_check_grace_period = 300

#   iam_instance_profile {
#       name = var.ec2_role_name  # Use the IAM role name imported from permissions module
#       # or
#       arn  = var.ec2_role_arn   # Use the IAM role ARN imported from permissions module
#     }
  tag {
    key                 = "Name"
    value               = "${var.owner}-yolov5-${var.project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
