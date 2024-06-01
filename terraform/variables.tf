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
description = "Deployment region"
type        = string
}

variable "availability_zone_2" {
  description = "Deployment region"
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

variable "polybot_machines" {
  description = "set the desired instances number"
  type        = number
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

################
# Polybot_vars #
################
variable "polybot_port" {
  description = "Deployment region"
  type        = string
}