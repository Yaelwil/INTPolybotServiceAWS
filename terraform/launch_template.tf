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
    security_groups = [aws_security_group.asg_sg.id]
  }

  user_data = <<-EOF
              #!/bin/bash
              # Add Docker's official GPG key:
              apt-get update
              apt-get install ca-certificates curl -y
              install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
              chmod a+r /etc/apt/keyrings/docker.asc

              # Add the repository to Apt sources:
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                tee /etc/apt/sources.list.d/docker.list > /dev/null
              apt-get update

              apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

              systemctl enable docker
              systemctl start docker
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
    security_groups = [aws_security_group.asg_sg.id]
  }

    user_data = file("./docker_installation.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.owner}-filters-${var.project}"
      Terraform = "true"
    }
  }
}
