resource "aws_instance" "polybot" {
  count                        = var.number_of_polybot_machines
  ami                          = var.ubuntu_ami
  instance_type                = var.instance_type
  subnet_id                    = element([var.public_subnet_1_id, var.public_subnet_2_id], count.index)
  security_groups              = [aws_security_group.polybot_sg.id]
  key_name                     = var.public_key
  associate_public_ip_address  = true
  iam_instance_profile         = var.iam_role
  user_data                    = file("${path.module}/user_data.sh")

  tags = {
    Name      = "${var.owner}-polybot-${var.project}-${count.index + 1}"
    Terraform = "true"
  }
}
