### VPC ###

# Create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "${var.owner}-vpc-${var.project}"
    Terraform = "true"
  }
}

### Subnets ###

# Create public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone_1 # Change the availability zone as needed

  tags = {
    Name = "${var.owner}-public-subnet-1-${var.project}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.availability_zone_2 # Change the availability zone as needed

  tags = {
    Name = "${var.owner}-public-subnet-2-${var.project}"
    Terraform = "true"
  }
}

### Internet Gateway ###

# Create an internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.owner}-igw-${var.project}"
    Terraform = "true"
  }
}

# Create a route table for public subnets
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name = "${var.owner}-public-route-table-${var.project}"
    Terraform = "true"
  }
}