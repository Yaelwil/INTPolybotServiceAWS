module "vpc" {
  source = "./modules/vpc"

  owner              = var.owner
  project            = "tf-project"
  main_vpc_cidr      = "10.0.0.0/16"
  public_subnet_1    = "10.0.1.0/24"
  public_subnet_2    = "10.0.2.0/24"
  first_telegram_cidr = "149.154.160.0/20"
  second_telegram_cidr = "91.108.4.0/22"
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "polybot" {
  source = "./modules/polybot"

  owner              = var.owner
  project            = var.project
  vpc_id = module.vpc.vpc_id
  polybot_port = "8443"
  iam_role           = var.iam_role
  instance_type      = var.instance_type
  number_of_polybot_machines = var.number_of_polybot_machines
  public_key = var.public_key
  public_subnet_1 = module.vpc.public_subnet_id_1
  public_subnet_2 = module.vpc.public_subnet_id_2
  ubuntu_ami = var.ubuntu_ami
}

module "resources" {
  source              = "./modules/resources"
  availability_zone_1 = module.vpc.availability_zone_1
  availability_zone_2 = module.vpc.availability_zone_2
  owner               = var.owner
  project             = var.project
  public_key          = var.public_key.name
  region              = var.region
}