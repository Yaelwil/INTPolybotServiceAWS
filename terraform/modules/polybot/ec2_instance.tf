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

  provisioner "file" {
    source      = local_file.env_file.filename
    destination = "/home/ubuntu/.env"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/yael/yaelwil-tf.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu/.env",
      "echo 'Environment file has been uploaded successfully.'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/yael/yaelwil-tf.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name      = "${var.owner}-polybot-${var.project}-${count.index + 1}"
    Terraform = "true"
  }
}
