output "owner" {
  description = "Owner of the infrastructure"
  value       = var.owner
}

output "project" {
  description = "project name"
  value       = var.project
}

output "polybot_port" {
  description = "Polybot port number"
  value       = var.polybot_port
}

output  "vpc_id" {
  description = "vpc id"
  value       = var.vpc_id
}

output "number_of_polybot_machines" {
  description = "Number of Polybot EC2 instances"
  value       = var.number_of_polybot_machines
}

output "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
  value       = var.ubuntu_ami
}

output "instance_type" {
  description = "EC2 instance type"
  value       = var.instance_type
}

output "public_key" {
  description = "SSH public key"
  value       = var.public_key
}

output "iam_role" {
  description = "IAM role name"
  value       = var.iam_role
}

output "public_subnet_1" {
  description = "public_subnet_1_id"
  value        = var.public_subnet_1
}

output "public_subnet_2" {
  description = "public_subnet_2_id"
  value        = var.public_subnet_2
}


output "instance_ids" {
  description = "List of instance IDs to register in the target group"
  value       = aws_instance.polybot[*].id
}