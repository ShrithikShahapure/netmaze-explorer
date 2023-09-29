variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID, Enter the vpc id of the following; can be found in the gui"
  default     = "network-sim-office-vpc"
}

variable "subnet_id_1" {
  description = "The subnet ID for web-app-1, Enter the subnet id of the following; can be found in the gui"
  default     = "network-sim-office-private-web-app-1-subnet-us-east-1a"
}

variable "subnet_id_2" {
  description = "The subnet ID for web-app-2, Enter the subnet id of the following; can be found in the gui"
  default     = "network-sim-office-private-web-app-2-subnet-us-east-1b"
}

variable "subnet_id_3" {
  description = "The subnet ID for web-app-2, Enter the subnet id of the following; can be found in the gui"
  default     = "network-sim-office-private-web-app-2-subnet-us-east-1b"
}

variable "subnet_id_4" {
  description = "The subnet ID for web-app-2, Enter the subnet id of the following; can be found in the gui"
  default     = "network-sim-office-private-web-app-2-subnet-us-east-1b"
}
