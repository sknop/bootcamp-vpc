
provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true


  tags = {
    Name = "partner-bootcamp-vpc"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Bootcamp IGW"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_subnet" "bootcamp-public-subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public-subnet-cidr
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Bootcamp Public Subnet"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Bootcamp Public Route Table"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id = aws_subnet.bootcamp-public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_subnet" "bootcamp-private-subnet-1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private-subnet-1-cidr
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Bootcamp Private Subnet 1"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_subnet" "bootcamp-private-subnet-2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private-subnet-2-cidr
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Bootcamp Private Subnet 2"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}


resource "aws_subnet" "bootcamp-private-subnet-3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private-subnet-3-cidr
  availability_zone = "eu-west-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "Bootcamp Private Subnet 3"
    owner_email = var.owner_email
    owner_name = var.owner_name
  }
}

resource "aws_security_group" "all-bootcamp" {
  name = "all-bootcamp-sg"
  description = "Allows free traffic between all instances within the bootcamp VPC"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow all access within the bootcamp"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "external-access" {
  name = "external-access-sg"
  description = "Allows free traffic from a specific IP"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow all access from a specific host"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.my-ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}