output "my_key_pair" {
  description = "List of IDs of the public subnets created"
  value       = aws_key_pair.my_key_pair.key_name
}