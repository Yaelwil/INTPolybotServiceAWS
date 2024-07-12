# need to create KMS key
# need to add Secret Manager secrets
# need to create ALB
# need to edit user data
# need to attach roles to the policies and to the EC2
# alb certificate-
# user data-
# TF- route 53
# subdomain
# permissions!!


region             = "eu-west-1"
availability_zone_1 = "eu-west-1a"
availability_zone_2 = "eu-west-1b"
iam_role = ""
instance_type= "t2.micro"
owner_name = "yaelwil"
project_name = "tf-project"
number_of_polybot_machines = 2
ubuntu_ami = "ami-0c38b837cd80f13bb"
polybot_port= 8443
main_vpc_cidr      = "10.0.0.0/16"
public_subnet_1    = "10.0.1.0/24"
public_subnet_2    = "10.0.2.0/24"
first_telegram_cidr = "149.154.160.0/20"
second_telegram_cidr = "91.108.4.0/22"
public_key_path    = "/home/yael/yaelwil-tf.pub"
yolov5_instance_type = "t2.medium"
filters_instance_type = "t2.micro"
yolov5_ebs_dev_name = "/dev/sdh"
yolov5_ebs_volume_size = 30
yolov5_ebs_volume_type = "gp2"
asg_filters_desired_capacity = 1
asg_filters_max_size = 5
asg_filters_min_size = 1
asg_yolov5_desired_capacity = 1
asg_yolov5_max_size = 5
asg_yolov5_min_size = 1
filters_ebs_dev_name = "/dev/sdh"
filters_ebs_volume_size = 20
filters_ebs_volume_type = "gp2"