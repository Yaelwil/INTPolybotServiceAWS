output "my_key_pair" {
  description = "SSH key"
  value       = aws_key_pair.my_key_pair.key_name
}

output "main_vpc_cidr" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}

output "main_vpc_id" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}

output "polybot_port" {
  description = "polybot_port"
  value       = var.polybot_port
}
output "first_telegram_cidr" {
  description = "first_telegram_cidr"
  value       = var.first_telegram_cidr
}
output "second_telegram_cidr" {
  description = "second_telegram_cidr"
  value       = var.second_telegram_cidr
}

output "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
  value       = var.ubuntu_ami
}

output "public_subnet_1" {
  description = "public_subnet_1"
  value       = var.public_subnet_1
}

output "public_subnet_2" {
  description = "public_subnet_2"
  value       = var.public_subnet_2
}

output "public_subnet_1_id" {
  description = "public_subnet_1_id"
  value       = var.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "public_subnet_2_id"
  value       = var.public_subnet_2_id
}