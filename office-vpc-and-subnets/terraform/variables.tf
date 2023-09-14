variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "19.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "19.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  default     = "us-east-1a"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "web_app_subnet_cidr_block" {
  description = "CIDR block for the web app subnets"
  default     = [
    "19.0.128.0/20",
    "19.0.16.0/20",
  ]
}

variable "data_subnet_cidr_block" {
  description = "CIDR block for the data subnets"
  default     = [
    "19.0.32.0/20",
    "19.0.166.0/20",
  ]
}

variable "web_app_subnet_availability_zones" {
  description = "Availability zones for the web app subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "data_subnet_availability_zones" {
  description = "Availability zones for the data subnets"
  default     = ["us-east-1a", "us-east-1b"]
}
