resource "aws_key_pair" "my_key_pair" {
  key_name   = "yaelwil-tf"
  public_key = file(var.public_key_path)

  tags = {
    Terraform   = "true"
  }
}
