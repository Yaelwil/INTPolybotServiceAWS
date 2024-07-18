#######
# VPC #
#######
resource "aws_vpc" "main-vpc" {
  cidr_block = var.main_vpc_cidr

  tags = {
    Name      = "${var.owner}-vpc-${var.project}"
    Terraform = "true"
  }
}

##################
# Public subnets #
##################
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.public_subnet_1
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.owner}-public-subnet-1-${var.project}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.public_subnet_2
  availability_zone = var.availability_zone_2
    map_public_ip_on_launch = true

  tags = {
    Name      = "${var.owner}-public-subnet-2-${var.project}"
    Terraform = "true"
  }
}

####################
# Internet Gateway #
####################
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name      = "${var.owner}-igw-${var.project}"
    Terraform = "true"
  }
}

###############
# Route table #
###############
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name      = "${var.owner}-public-route-table-${var.project}"
    Terraform = "true"
  }
}

#################
# Network ACL's #
#################
resource "aws_network_acl" "public_network_acl" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.owner}-network-acl-${var.project}"
  }
}

##############################
# Inbound and outbound rules #
##############################
#################
# Inbound Rules #
#################
resource "aws_network_acl_rule" "allow_all_inbound" {
  network_acl_id = aws_network_acl.public_network_acl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 0      // Allow all ports from 0
  to_port        = 65535  // Allow all ports up to 65535
}

#################
# Outbound Rules #
#################
resource "aws_network_acl_rule" "allow_all_outbound" {
  network_acl_id = aws_network_acl.public_network_acl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 0      // Allow all ports from 0
  to_port        = 65535  // Allow all ports up to 65535
}

######################################
# Associate route table with subnets #
######################################
resource "aws_route_table_association" "rt_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-rt.id
}

######################################
# Associate network acl with subnets #
######################################
resource "aws_network_acl_association" "nacl_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  network_acl_id = aws_network_acl.public_network_acl.id
}

resource "aws_network_acl_association" "nacl_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  network_acl_id = aws_network_acl.public_network_acl.id
}
