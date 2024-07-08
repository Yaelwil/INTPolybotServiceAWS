module "vpc" {
  source = "./modules/vpc"

  owner              = var.owner_name
  project            = var.project_name
  main_vpc_cidr      = var.main_vpc_cidr
  public_subnet_1    = var.public_subnet_1
  public_subnet_2    = var.public_subnet_2
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "polybot" {
  source = "./modules/polybot"

  owner              = var.owner_name
  project            = var.project_name
  vpc_id = module.vpc.vpc_id
  polybot_port = var.polybot_port
  iam_role           = var.iam_role
  instance_type      = var.instance_type
  number_of_polybot_machines = var.number_of_polybot_machines
  public_key = module.resources.my_key_pair
  public_subnet_1 = module.vpc.public_subnet_id_1
  public_subnet_2 = module.vpc.public_subnet_id_2
  ubuntu_ami = var.ubuntu_ami
}

module "resources" {
    source = "./modules/resources"

  owner              = var.owner_name
  project            = var.project_name

  main_vpc_cidr      = var.main_vpc_cidr
  main_vpc_id = module.vpc.vpc_id
  public_subnet_1 = var.public_subnet_1
  public_subnet_2 = var.public_subnet_2

  public_key_path    = var.public_key_path

  first_telegram_cidr = var.first_telegram_cidr
  second_telegram_cidr = var.second_telegram_cidr

  filters_instance_type = var.filters_instance_type

  ubuntu_ami = var.ubuntu_ami
  polybot_port = var.polybot_port
  public_subnet_1_id = module.vpc.public_subnet_id_1
  public_subnet_2_id = module.vpc.public_subnet_id_2
}

module "yolov5_filters" {
  source = "./modules/yolov5_filters"

  yolov5_instance_type = var.yolov5_instance_type
  yolov5_ebs_dev_name = var.yolov5_ebs_dev_name
  yolov5_ebs_volume_size = var.yolov5_ebs_volume_size
  yolov5_ebs_volume_type = var.yolov5_ebs_volume_type
  asg_filters_desired_capacity = var.asg_filters_desired_capacity
  asg_filters_max_size = var.asg_filters_max_size
  asg_filters_min_size = var.asg_filters_min_size
  asg_yolov5_desired_capacity = var.asg_yolov5_desired_capacity
  asg_yolov5_max_size = var.asg_yolov5_max_size
  asg_yolov5_min_size = var.asg_yolov5_min_size
  main_vpc_id        = module.vpc.vpc_id
  owner              = var.owner_name
  project            = var.project_name
  public_key_path    = var.public_key_path
  public_subnet_1_id = module.vpc.public_subnet_id_1
  public_subnet_2_id = module.vpc.public_subnet_id_2
}


