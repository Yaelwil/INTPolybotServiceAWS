#############
# Main vars #
#############
variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
}

variable "project" {
  description = "project name"
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
description = "first availability zone"
type        = string
}

variable "availability_zone_2" {
  description = "second availability zone"
  type        = string
}

variable "public_key_path" {
  description = "SSH key"
  type        = string
}

##################
# Telegram cidrs #
##################
variable "first_telegram_cidr" {
  description = "telegram bots webhook" # https://core.telegram.org/bots/webhooks
  type        = string
}

variable "second_telegram_cidr" {
  description = "telegram bots webhook"
  type        = string
}

################
# Network Vars #
################
variable "main_vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "The CIDR block for the first public subnet"
  type        = string
}


variable "public_subnet_2" {
  description = "The CIDR block for the second public subnet"
  type        = string
}

#########################
# EC2 instance settings #
#########################

variable "ubuntu_ami" {
  description = "desired ubuntu ami"
  type        = string
}

variable "instance_type" {
  description = "set the desired instance type"
  type        = string
}

################
# Polybot vars #
################
variable "polybot_machines" {
  description = "set the desired instances number"
  type        = number
}

variable "polybot_port" {
  description = "Polybot port number"
  type        = string
}

###############
# Yolov5 vars #
################

variable "yolov5_port" {
  description = "Yolov5 port number"
  type        = string
}

variable "yolov5_instance_type" {
  description = "Yolov5 instance type"
  type        = string
}

################
# filters vars #
################

variable "filters_instance_type" {
  description = "filters instance type"
  type        = string
}

###########################
# Auto scaling group vars #
###########################

variable "desired_capacity" {
  description = "desired number of instances in the Auto Scaling Group when it is created"
  type        = number
}

variable "min_size" {
  description = "Minimum running instances"
  type        = number
}

variable "max_size" {
  description = "Maximum running instances"
  type        = number
}