# Main vars
owner = "yaelwil"
project = "tf-project"

# General AWS vars
region = "eu-west-2"
availability_zone_1 = "eu-west-2a"
availability_zone_2 = "eu-west-2b"
public_key_path = "~/yaelwil-tf.pub"

# Telegram cidrs
first_telegram_cidr = "149.154.160.0/20"
second_telegram_cidr = "91.108.4.0/22"

# Network Vars
main_vpc_cidr = "10.0.0.0/16"
public_subnet_1 = "10.0.1.0/24" # associated with availability_zone_1
public_subnet_2 = "10.0.2.0/24" # associated with availability_zone_2

# ec2 instance settings
ubuntu_ami = "ami-053a617c6207ecc7b"
instance_type = "t2.micro"

# Polybot vars
polybot_machines = 2
polybot_ami = ""
polybot_port = "8443"

# Yolov5 vars
yolov5_ami = ""
yolov5_port = "8081"
yolov5_instance_type = "t2.medium"

# Auto scaling group vars
desired_capacity = 2
