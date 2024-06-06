#########################
# polybot EC2 instances #
#########################
resource "aws_instance" "polybot" {
  count         = var.polybot_machines
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