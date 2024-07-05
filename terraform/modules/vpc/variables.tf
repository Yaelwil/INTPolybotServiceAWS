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
variable "availability_zone_1" {
description = "first availability zone"
type        = string
}

variable "availability_zone_2" {
  description = "second availability zone"
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
