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

output "yolov5_instance_type" {
  description = "yolov5_instance_type"
  value       = var.yolov5_instance_type
}

output "filters_instance_type" {
  description = "filters_instance_type"
  value       = var.filters_instance_type
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

output "yolov5_ebs_dev_name" {
  description = "yolov5_ebs_dev_name"
  value       = var.yolov5_ebs_dev_name
}

output "yolov5_ebs_volume_size" {
  description = "yolov5_ebs_volume_size"
  value       = var.yolov5_ebs_volume_size
}

output "yolov5_ebs_volume_type" {
  description = "filters_instance_type"
  value       = var.yolov5_ebs_volume_type
}

output "asg_filters_min_size" {
  description = "asg_filters_min_size"
  value       = var.asg_filters_min_size
}

output "asg_yolov5_min_size" {
  description = "asg_yolov5_min_size"
  value       = var.asg_yolov5_min_size
}

output "asg_filters_desired_capacity" {
  description = "asg_filters_desired_capacity"
  value       = var.asg_filters_desired_capacity
}

output "asg_filters_max_size" {
  description = "asg_filters_max_size"
  value       = var.asg_filters_max_size
}

output "asg_yolov5_max_size" {
  description = "asg_yolov5_max_size"
  value       = var.asg_yolov5_max_size
}

output "asg_yolov5_desired_capacity" {
  description = "asg_yolov5_desired_capacity"
  value       = var.asg_yolov5_desired_capacity
}