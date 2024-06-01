# Create launch template
resource "aws_launch_template" "yolov5_launch_template" {
  name_prefix   = "yolov5-launch-template-"

  #TODO add yolov5 AMI ID
  image_id      = var.ubuntu_ami # Replace with your YOLOv5 AMI ID
  instance_type = var.instance_type
  key_name      = var.public_key_path

  tags = {
    Name = "${var.owner}-yolov5_launch_template-${var.project}"
    Terraform = "true"
  }
}