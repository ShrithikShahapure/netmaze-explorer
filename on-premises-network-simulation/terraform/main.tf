# Set the AWS provider with the default region as "us-east-1"
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "network_sim_on_prem_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "network_sim_on_prem_igw" {
  vpc_id = aws_vpc.network_sim_on_prem_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet1_us_east_1a" {
  vpc_id     = aws_vpc.network_sim_on_prem_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
  }
}

# Create a Route Table for the Public Subnet
resource "aws_route_table" "network_sim_on_prem_rtb_public" {
  vpc_id = aws_vpc.network_sim_on_prem_vpc.id
  tags = {
    Name = var.public_route_table_name
  }
}

# Create a Route in the Public Subnet's Route Table to route traffic to the Internet Gateway
resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.network_sim_on_prem_rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.network_sim_on_prem_igw.id
}
