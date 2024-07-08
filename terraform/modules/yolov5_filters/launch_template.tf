##########################
# Yolov5 launch template #
##########################

resource "aws_launch_template" "yolov5_launch_template" {
  name = "${var.owner}-yolov5-${var.project}"

  lifecycle {
    create_before_destroy = true
  }

  image_id      = var.ubuntu_ami
  instance_type = var.yolov5_instance_type

  key_name = var.public_key_path

  network_interfaces {
    associate_public_ip_address = true
    # Use the first subnet as a placeholder
    subnet_id                   = var.public_subnet_1_id
    security_groups = [aws_security_group.asg_sg.id]
  }
  block_device_mappings {
    device_name = var.yolov5_ebs_dev_name
    ebs {
      volume_size = var.yolov5_ebs_volume_size
      volume_type = var.yolov5_ebs_volume_type
      delete_on_termination = true
    }
  }

    user_data = base64encode(file("${path.module}/user_data_yolov5.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.owner}-yolov5-${var.project}"
      Terraform = "true"
    }
  }
}

###########################
# filters launch template #
###########################

resource "aws_launch_template" "filters_launch_template" {
  name = "${var.owner}-filters-${var.project}"

  lifecycle {
    create_before_destroy = true
  }

  image_id      = var.ubuntu_ami
  instance_type = var.filters_instance_type

  key_name = var.public_key_path

  network_interfaces {
    associate_public_ip_address = true
    # Use the first subnet as a placeholder
    subnet_id                   = var.public_subnet_2_id
    security_groups = [aws_security_group.asg_sg.id]
  }

  block_device_mappings {
    device_name = var.filters_ebs_dev_name
    ebs {
      volume_size = var.filters_ebs_volume_size
      volume_type = var.filters_ebs_volume_type
      delete_on_termination = true
    }
  }
    user_data = base64encode(file("${path.module}/user_data_filters.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.owner}-filters-${var.project}"
      Terraform = "true"
    }
  }
}