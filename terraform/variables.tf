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