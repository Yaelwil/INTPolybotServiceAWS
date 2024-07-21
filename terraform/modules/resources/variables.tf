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

variable "region" {
  description = "region"
  type        = string
}

variable "public_key_path" {
  description = "SSH key"
  type        = string
}

variable "main_vpc_cidr" {
  description = "main_vpc_cidr"
  type        = string
}

variable "main_vpc_id" {
  description = "main_vpc_id"
  type        = string
}

variable "polybot_port" {
  description = "polybot_port"
  type        = number
}
variable "first_telegram_cidr" {
  description = "first_telegram_cidr"
  type        = string
}

variable "second_telegram_cidr" {
  description = "second_telegram_cidr"
  type        = string
}

variable "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
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

variable "public_subnet_1_id" {
  description = "public_subnet_1_id"
  type        = string
}

variable "public_subnet_2_id" {
  description = "public_subnet_2_id"
  type        = string
}

variable "filters_instance_type" {
  description = "The instance type for filtering"
  type        = string
}

variable "instance_ids" {
  type = list(string)
  description = "List of instance IDs to register in the target group"
}