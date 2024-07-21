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
  iam_role           = module.permissions.ec2_instance_profile
  instance_type      = var.instance_type
  number_of_polybot_machines = var.number_of_polybot_machines
  public_key = module.resources.key_pair_name
  ubuntu_ami = var.ubuntu_ami
  public_subnet_1_id = module.vpc.public_subnet_id_1
  public_subnet_2_id = module.vpc.public_subnet_id_1
  public_subnet_1    = var.public_subnet_1
  public_subnet_2    = var.public_subnet_2
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
  instance_ids = module.polybot.instance_ids
  region = var.region
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
  public_key_path    = module.resources.key_pair_name
  public_subnet_1_id = module.vpc.public_subnet_id_1
  public_subnet_2_id = module.vpc.public_subnet_id_2
  filters_instance_type = var.filters_instance_type
  filters_ebs_dev_name = var.filters_ebs_dev_name
  filters_ebs_volume_size = var.filters_ebs_volume_size
  filters_ebs_volume_type = var.filters_ebs_volume_type
  main_vpc_cidr = module.vpc.vpc_id
  ubuntu_ami = var.ubuntu_ami
  iam_instance_profile = module.permissions.ec2_instance_profile
}

module "permissions" {
  source = "./modules/permissions"
  owner              = var.owner_name
  project            = var.project_name
  bucket_arn = module.resources.bucket_arn
  dynamodb_table_arn = module.resources.dynamodb_table_arn
  yolov5_sqs_queue_arn = module.resources.yolov5_sqs_queue_arn
  filters_sqs_queue_arn = module.resources.filters_sqs_queue_arn
  main_vpc_cidr = var.main_vpc_cidr
  region = var.region
}