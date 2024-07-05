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


variable "public_key" {
  description = "SSH public key to be added to EC2 instance"
  type        = string
  default     = file("~/yaelwil-tf.pub")  # Path to your public key file
}