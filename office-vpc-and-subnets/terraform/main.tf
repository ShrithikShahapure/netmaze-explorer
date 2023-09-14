provider "aws" {
  region = var.aws_region
}

# Create the VPC
resource "aws_vpc" "network-sim-office-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "network-sim-office-vpc"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "network-sim-office-igw" {
  vpc_id = aws_vpc.network-sim-office-vpc.id
  tags = {
    Name = "network-sim-office-igw"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.network-sim-office-vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "network-sim-office-public-subnet-${var.availability_zone}"
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.network-sim-office-vpc.id
  tags = {
    Name = "network-sim-office-rtb-public-${var.availability_zone}"
  }
}

# Create a route to send traffic to the Internet Gateway
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.public_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.network-sim-office-igw.id
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

# Create a NAT Gateway
resource "aws_nat_gateway" "net-sim-office-nat-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "net-sim-office-nat-gateway"
  }
}

# Create EIP for NAT Gateway
resource "aws_eip" "nat_eip" {
  instance = aws_nat_gateway.net-sim-office-nat-gateway.id
}

# Create additional subnets
resource "aws_subnet" "web_app_subnets" {
  count                   = length(var.web_app_subnet_cidr_block)
  vpc_id                  = aws_vpc.network-sim-office-vpc.id
  cidr_block              = var.web_app_subnet_cidr_block[count.index]
  availability_zone       = var.web_app_subnet_availability_zones[count.index]
  map_public_ip_on_launch = false # Private subnet

  tags = {
    Name = "network-sim-office-private-web-app-${count.index + 1}-subnet-${var.availability_zone[count.index]}"
  }
}

resource "aws_subnet" "data_subnets" {
  count                   = length(var.data_subnet_cidr_block)
  vpc_id                  = aws_vpc.network-sim-office-vpc.id
  cidr_block              = var.data_subnet_cidr_block[count.index]
  availability_zone       = var.data_subnet_availability_zones[count.index]
  map_public_ip_on_launch = false # Private subnet

  tags = {
    Name = "network-sim-office-private-data-${count.index + 1}-subnet-${var.availability_zone[count.index]}"
  }
}

# Create route tables for the web app and data subnets
resource "aws_route_table" "web_app_route_tables" {
  count = length(var.web_app_subnet_cidr_block)
  vpc_id = aws_vpc.network-sim-office-vpc.id
  tags = {
    Name = "network-sim-office-web-app-${count.index + 1}-rtb"
  }
}

resource "aws_route_table" "data_route_tables" {
  count = length(var.data_subnet_cidr_block)
  vpc_id = aws_vpc.network-sim-office-vpc.id
  tags = {
    Name = "network-sim-office-data-${count.index + 1}-rtb"
  }
}

# Create routes to the NAT Gateway for the web app and data subnets
resource "aws_route" "web_app_route_to_nat" {
  count               = length(var.web_app_subnet_cidr_block)
  route_table_id      = aws_route_table.web_app_route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id      = aws_nat_gateway.net-sim-office-nat-gateway.id
}

resource "aws_route" "data_route_to_nat" {
  count               = length(var.data_subnet_cidr_block)
  route_table_id      = aws_route_table.data_route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id      = aws_nat_gateway.net-sim-office-nat-gateway.id
}
