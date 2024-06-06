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

  key_name = aws_key_pair.public_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    # Use the first subnet as a placeholder
    subnet_id                   = aws_subnet.public_subnet_1.id
  }

  user_data = <<-EOF
              #!/bin/bash
              # Your user data script to install and configure YOLOv5
              EOF

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

  key_name = aws_key_pair.public_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    # Use the first subnet as a placeholder
    subnet_id                   = aws_subnet.public_subnet_1.id
  }

  user_data = <<-EOF
              #!/bin/bash
              # Your user data script to install and configure filters
              EOF

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.owner}-filters-${var.project}"
      Terraform = "true"
    }
  }
}
