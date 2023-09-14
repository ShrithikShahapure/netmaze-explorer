provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_instance" "web_app_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id_1
  key_name      = "all-projects"
  associate_public_ip_address = false
  tags = {
    Name = "web-app-1"
  }
}

resource "aws_instance" "web_app_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id_2
  key_name      = "all-projects"
  associate_public_ip_address = false
  tags = {
    Name = "web-app-2"
  }
}

resource "aws_security_group" "web_app_sg" {
  name_prefix = "web-app-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Local VPC CIDR block
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Local VPC CIDR block
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Local VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "data_sg" {
  name        = "data_1_sg"
  description = "Example security group"

  # Ingress rule for SSH and MySQL from local VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  # Replace with your VPC CIDR block
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  
  }

  # Ingress rule for HTTP and HTTPS from NAT Gateway
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["NAT_GATEWAY_IP/32"]  # Replace with your NAT Gateway IP address
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["NAT_GATEWAY_IP/32"]  # Replace with your NAT Gateway IP address
  }

  # Egress rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

resource "aws_db_instance" "data_1" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"  # Change to your desired database engine (e.g., "postgres", "sqlserver")
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = "yourpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.example_sg.id]
  subnet_group_name      = var.subnet_id_3  # You can create a DB subnet group separately

  # Optionally, you can specify a publicly accessible RDS instance:
  publicly_accessible = true

  tags = {
    Name = "example-rds-instance"
  }
}



resource "aws_security_group" "data_2_sg" {
  name        = "data_2_sg"
  description = "Example security group"

  # Ingress rule for SSH and MySQL from local VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["19.0.0.0/16"]  
  }

  # Ingress rule for HTTP and HTTPS from NAT Gateway
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["NAT_GATEWAY_IP/32"]  # Replace with your NAT Gateway IP address
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["NAT_GATEWAY_IP/32"]  # Replace with your NAT Gateway IP address
  }

  # Egress rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

resource "aws_db_instance" "data_2" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"  # Change to your desired database engine (e.g., "postgres", "sqlserver")
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = "yourpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.example_sg.id]
  subnet_group_name      = var.subnet_id_4  # You can create a DB subnet group separately

  # Optionally, you can specify a publicly accessible RDS instance:
  publicly_accessible = true

  tags = {
    Name = "example-rds-instance"
  }
}
