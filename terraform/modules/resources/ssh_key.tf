resource "tls_private_key" "aws_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "aws_key_pair" "my_key_pair" {
  key_name   = "yaelwil-tf"
  public_key = tls_private_key.aws_key.public_key_openssh

  tags = {
    Terraform   = "true"
  }
}

# resource "aws_key_pair" "my_key_pair" {
#   key_name   = "yaelwil-tf"
#   public_key = file(var.public_key_path)
#
#   tags = {
#     Terraform   = "true"
#   }
# }
