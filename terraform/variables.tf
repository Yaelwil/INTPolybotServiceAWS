########################
# General project vars #
########################

variable "owner_name" {
  description = "owner_name"
type        = string
}

variable "project_name" {
  description = "project_name"
type        = string
}

####################
# General AWS vars #
####################
variable "region" {
description = "Deployment region"
type        = string
}

variable "availability_zone_1" {
  description = "AWS availability zone 1"
type        = string
}

variable "availability_zone_2" {
  description = "AWS availability zone 2"
type        = string
}


##############
# Other vars #
##############
variable "iam_role" {
  description = "iam_role"
type        = string
}

variable "instance_type" {
  description = "instance_type"
type        = string
}

variable "polybot_port" {
  description = "polybot_port"
type        = number
}

variable "number_of_polybot_machines" {
  description = "number_of_polybot_machines"
type        = number
}

variable "ubuntu_ami" {
  description = "ubuntu_ami"
type        = string
}

variable "main_vpc_cidr" {
  description = "main_vpc_cidr"
type        = string
}

variable "public_subnet_1" {
  description = "public_subnet_1"
type        = string
}

variable "public_subnet_2" {
  description = "public_subnet_2"
type        = string
}

variable "first_telegram_cidr" {
  description = "first_telegram_cidr"
type        = string
}

variable "second_telegram_cidr" {
  description = "second_telegram_cidr"
type        = string
}

variable "public_key_path" {
  description = "public ssh key path"
  type = string
}

variable "yolov5_instance_type" {
  description = "yolov5_instance_type"
  type        = string
}

variable "filters_instance_type" {
  description = "filters_instance_type"
  type        = string
}

variable "yolov5_ebs_dev_name" {
  description = "yolov5_ebs_dev_name"
  type        = string
}

variable "yolov5_ebs_volume_size" {
  description = "yolov5_ebs_volume_size"
  type        = number
}

variable "yolov5_ebs_volume_type" {
  description = "yolov5_ebs_volume_type"
  type        = string
}