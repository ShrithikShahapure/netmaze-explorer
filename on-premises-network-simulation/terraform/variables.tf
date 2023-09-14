# Define VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "15.0.0.0/16"
}

# Define Public Subnet CIDR block
variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "15.0.0.0/20"
}

# Define VPC and resource names
variable "vpc_name" {
  description = "Name of the VPC"
  default     = "network-sim-on-prem-vpc"
}

variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  default     = "network-sim-on-prem-vpc"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  default     = "network-sim-on-prem-subnet-public1-us-east-1a"
}

variable "public_route_table_name" {
  description = "Name of the public subnet's route table"
  default     = "network-sim-on-prem-rtb-public"
}
