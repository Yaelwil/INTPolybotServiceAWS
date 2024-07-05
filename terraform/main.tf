module "vpc" {
  source = "./modules/vpc"

  owner              = var.owner_name
  project            = var.project_name
  main_vpc_cidr      = var.main_vpc_cidr
  public_subnet_1    = var.public_subnet_1
  public_subnet_2    = var.public_subnet_2
  first_telegram_cidr = var.first_telegram_cidr
  second_telegram_cidr = var.second_telegram_cidr
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
  public_key_path    = var.public_key_path
  main_vpc_cidr      = var.main_vpc_cidr
}