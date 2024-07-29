output "region" {
  description = "AWS region"
  value       = var.region
}

output "availability_zone_1" {
  description = "AWS availability zone 1"
  value       = var.availability_zone_1
}

output "availability_zone_2" {
  description = "AWS availability zone 1"
  value       = var.availability_zone_2
}

output "owner_name" {
  description = "owner"
  value       = var.owner_name
}

output "project_name" {
  description = "project"
  value       = var.project_name
}

output "number_of_polybot_machines" {
  description = "number_of_polybot_machines"
  value       = var.number_of_polybot_machines
}

output "ubuntu_ami" {
  description = "ubuntu_ami"
  value       = var.ubuntu_ami
}

output "main_vpc_cidr" {
  description = "main_vpc_cidr"
  value       = var.main_vpc_cidr
}

output "public_subnet_1" {
  description = "public_subnet_1"
  value       = var.public_subnet_1
}

output "public_subnet_2" {
  description = "public_subnet_2"
  value       = var.public_subnet_2
}

output "first_telegram_cidr" {
  description = "first_telegram_cidr"
  value       = var.first_telegram_cidr
}

output "second_telegram_cidr" {
  description = "second_telegram_cidr"
  value       = var.second_telegram_cidr
}

# output "public_key_path" {
#   description = "public ssh key path"
#   value       = var.public_key_path
# }

output "yolov5_instance_type" {
  description = "yolov5_instance_type"
  value       = var.yolov5_instance_type
}

output "filters_instance_type" {
  description = "filters_instance_type"
  value       = var.filters_instance_type
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
  description = "asg_xilters_max_size"
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

output "filters_ebs_dev_name" {
  description = "filters_ebs_dev_name"
  value       = var.filters_ebs_dev_name
}

output "filters_ebs_volume_size" {
  description = "filters_ebs_volume_size"
  value       = var.filters_ebs_volume_size
}

output "filters_ebs_volume_type" {
  description = "filters_ebs_volume_type"
  value       = var.filters_ebs_volume_type
}