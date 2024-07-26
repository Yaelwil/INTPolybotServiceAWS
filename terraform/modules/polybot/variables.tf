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

variable "public_subnet_1" {
  description = "public_subnet_1_id"
  type        = string
}

variable "public_subnet_2" {
  description = "public_subnet_2_id"
  type        = string
}

variable "bucket_name" {
  description = "bucket name"
  type        = string
}

variable "alb_url" {
  description = "alb_url"
  type        = string
}

variable "dynamodb_table_name" {
  description = "dynamodb_table_name"
  type        = string
}

variable "filters_queue_url" {
  description = "filters_queue_url"
  type        = string
}

variable "yolo_queue_url" {
  description = "yolo_queue_url"
  type        = string
}

variable "aws_region" {
  description = "aws_region"
  type        = string
}