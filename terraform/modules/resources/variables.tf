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

variable "main_vpc_cidr" {
  description = "main_vpc_cidr"
  type        = string
}