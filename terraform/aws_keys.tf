resource "aws_key_pair" "deployer" {
  key_name   = "my-key"
  public_key = file(var.public_key_path)
}