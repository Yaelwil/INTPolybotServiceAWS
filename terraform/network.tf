#######
# VPC #
#######
resource "aws_vpc" "main-vpc" {
  cidr_block = var.main_vpc_cidr

  tags = {
    Name = "${var.owner}-vpc-${var.project}"
    Terraform = "true"
  }
}
###########
# Subnets #
###########
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.public_subnet_1
  availability_zone = var.availability_zone_1 # Change the availability zone as needed

  tags = {
    Name = "${var.owner}-public-subnet-1-${var.project}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.public_subnet_2
  availability_zone = var.availability_zone_2 # Change the availability zone as needed

  tags = {
    Name = "${var.owner}-public-subnet-2-${var.project}"
    Terraform = "true"
  }
}

####################
# Internet Gateway #
####################
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.owner}-igw-${var.project}"
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
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name = "${var.owner}-public-route-table-${var.project}"
    Terraform = "true"
  }
}

#############
# ACL rules #
#############

resource "aws_network_acl" "acl_rules" {
  vpc_id = aws_vpc.main-vpc.id
}
resource "aws_network_acl_rule" "allow_internal_traffic" {
  network_acl_id = aws_network_acl.acl_rules.id
  rule_number    = 1
  protocol       = "-1"  # Allow all protocols
  rule_action    = "allow"
  cidr_block     = aws_vpc.main-vpc.cidr_block
  egress         = true  # Apply to outbound traffic
}

resource "aws_network_acl_rule" "allow_s3_access" {
  network_acl_id = aws_network_acl.acl_rules.id
  rule_number    = 2
  protocol       = "6"  # TCP protocol
  rule_action    = "allow"
  cidr_block     = aws_vpc.main-vpc.cidr_block # Replace with the CIDR block for S3 in your region
  egress         = true  # Apply to outbound traffic
  from_port      = 443  # S3 uses HTTPS (port 443)
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_ssh_traffic" {
  network_acl_id = aws_network_acl.acl_rules.id
  rule_number    = 3
  protocol       = "-1"  # Allow all protocols
  rule_action    = "allow"
  cidr_block     = aws_vpc.main-vpc.cidr_block
  egress         = false  # Apply to outbound traffic
  from_port      = 22  # S3 uses HTTPS (port 443)
  to_port        = 22
}