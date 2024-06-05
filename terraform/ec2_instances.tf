#########################
# polybot EC2 instances #
#########################
resource "aws_instance" "polybot" {
#  count         = var.polybot_machines
  count = 1
  #TODO need to replace with polybot ami
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  subnet_id     = element([aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id], count.index)
  security_groups = [aws_security_group.polybot_sg.id]
  key_name = aws_key_pair.public_key.key_name
  associate_public_ip_address = true  # Enable auto-assigned public IP address
  iam_instance_profile = aws_iam_instance_profile.polybot_instance_profile.name

  tags = {
    Name = "${var.owner}-polybot-${var.project}-${count.index + 1 }"
  }
}

########################
# yolov5 EC2 instances #
########################
resource "aws_instance" "yolov5" {
  count         = 1
  #TODO need to replace with polybot ami
  ami           = var.ubuntu_ami
  instance_type = var.yolov5_instance_type
  subnet_id     = element([aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id], count.index)
  security_groups = [aws_security_group.yolov5_sg.id]
  key_name = aws_key_pair.public_key.key_name
  associate_public_ip_address = true  # Enable auto-assigned public IP address
  iam_instance_profile = aws_iam_instance_profile.yolov5_instance_profile.name

  tags = {
    Name = "${var.owner}-yolov5-${var.project}-${count.index + 1 }"
    Terraform = "true"
  }
}
