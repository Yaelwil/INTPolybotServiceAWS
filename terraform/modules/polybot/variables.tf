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

##########
# VPC ID #
##########
variable "vpc_id" {
  description = "vpc id"
  type        = string
}

#######################
# Polybot port number #
#######################
variable "polybot_port" {
  description = "Polybot port number"
  type        = string
}

variable "number_of_polybot_machines" {
  description = "Number of Polybot EC2 instances to launch"
  type        = number
}

variable "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}

variable "iam_role" {
  description = "IAM role name"
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