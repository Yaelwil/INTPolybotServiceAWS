output "vpc_id" {
  description = "The ID of the VPC created"
  value       = aws_vpc.main-vpc.id
}

output "public_subnet_id_1" {
  description = "List of IDs of the public subnets created"
  value       = aws_subnet.public_subnet_1.id,
}

output "public_subnet_id_2" {
  description = "List of IDs of the public subnets created"
  value       = aws_subnet.public_subnet_2.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway created"
  value       = aws_internet_gateway.main-igw.id
}

output "public_route_table_id" {
  description = "The ID of the public route table created"
  value       = aws_route_table.public-rt.id
}

output "public_network_acl_id" {
  description = "The ID of the public network ACL created"
  value       = aws_network_acl.public_network_acl.id
}

output "first_telegram_cidr" {
  description = "CIDR block for the first Telegram webhook"
  value       = var.first_telegram_cidr
}

output "second_telegram_cidr" {
  description = "CIDR block for the second Telegram webhook"
  value       = var.second_telegram_cidr
}

output "availability_zone_1" {
  description = "availability_zone_1"
  value       = var.availability_zone_1
}

output "availability_zone_2" {
  description = "availability_zone_2"
  value       = var.availability_zone_2
}