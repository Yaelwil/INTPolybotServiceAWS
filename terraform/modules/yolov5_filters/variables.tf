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


variable "public_key_path" {
  description = "SSH key"
  type        = string
}

variable "main_vpc_id" {
  description = "main_vpc_id"
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

variable "asg_filters_min_size" {
  description = "asg_filters_min_size"
  type        = number
}

variable "asg_filters_max_size" {
  description = "asg_filters_max_size"
  type        = number
}

variable "asg_filters_desired_capacity" {
  description = "asg_filters_desired_capacity"
  type        = number
}

variable "asg_yolov5_min_size" {
  description = "asg_filters_min_size"
  type        = number
}

variable "asg_yolov5_max_size" {
  description = "asg_yolov5_max_size"
  type        = number
}

variable "asg_yolov5_desired_capacity" {
  description = "asg_yolov5_desired_capacity"
  type        = number
}

variable "yolov5_instance_type" {
  description = "yolov5_instance_type"
  type        = string
}

variable "filters_instance_type" {
  description = "filters_instance_type"
  type        = string
}