provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_instance" "bastion-host" {
  ami           = "ami-0f844a9675b22ea32"
  instance_type = t2.micro
  subnet_id     = "subnet-099e93950b92b1d81" # add id of network-sim-office-public-subnet-us-east-1a
  key_name      = "all-projects"
  associate_public_ip_address = true
  tags = {
    Name = "web-app-1"
  }
}

resource "aws_security_group" "web_app_sg" {
  name_prefix = "web-app-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  # Local VPC CIDR block
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  # Local VPC CIDR block
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  # Local VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
