provider "aws" {
  region = "us-east-1" # Change this to your desired region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "19.0.0.0/16" # Replace with your VPC's CIDR block
}

resource "aws_subnet" "subnet" {
  count = 2 # Number of subnets you want to associate with the ALB
  vpc_id = aws_vpc.my_vpc.id
  # Define your subnet configurations here
}

resource "aws_security_group" "alb_sg" {
  name_prefix   = "alb-sg-"
  description   = "Security group for Application Load Balancer"
  vpc_id        = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false # Set to true for an internal ALB
  load_balancer_type = "application"
  enable_deletion_protection = false # Set to true if you want to enable deletion protection

  security_groups = [aws_security_group.alb_sg.id]
  subnets         = aws_subnet.subnet[*].id
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "Hello, world!"
    }
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "my_target_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = "INSTANCE_ID" # Replace with the actual instance ID(s) you want to attach to the target group
}

output "alb_dns_name" {
  value = aws_lb.my_alb.dns_name
}
