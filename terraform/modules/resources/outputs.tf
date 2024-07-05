output "my_key_pair" {
  description = "SSH key"
  value       = aws_key_pair.my_key_pair.key_name
}

output "main_vpc_cidr" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}