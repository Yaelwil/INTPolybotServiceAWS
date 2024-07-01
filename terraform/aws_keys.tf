resource "aws_key_pair" "public_key" {
  key_name   = "yaelwil-tf"
  public_key = file(var.public_key_path)
}