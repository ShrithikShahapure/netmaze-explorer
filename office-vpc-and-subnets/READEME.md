# 1.AWS Virtual Network Setup
 - The first step in the project is to build the office infrastructure

- This repository contains Terraform configurations to automate the creation of AWS infrastructure. It includes the setup of a VPC, Internet Gateway, NAT Gateway, and multiple subnets in different availability zones.

## What's being created:

- VPC called "network-sim-office-vpc" of CIDR 19.0.0.0/16

- Internet Gateway called "network-sim-office-igw" and attatching it to above VPC

- NAT gateway with Elastic IP

- Public Subnet called network-sim-office-public-subnet-us-east-1a with route table

- Private Subnet called network-sim-office-private-web-app-1-subnet-us-east-1a with route table

- Private Subnet called network-sim-office-private-web-app-2-subnet-us-east-1b with route table

- Private Subnet called network-sim-office-private-data-1-subnet-us-east-1a with route table

- Private Subnet called network-sim-office-private-data-2-subnet-us-east-1b with route table

## Prerequisites
Make sure you have Terraform installed and you configured your aws cli, and stored your access-key and secret-access-key locally in your .env

### 1. Create a terraform Directory
Create a terraform directory within the repository to organize your Terraform configuration files. Inside this directory, place your Terraform configuration files, such as main.tf, variables.tf, and terraform.tfvars (if needed).

### 2. Define Variables
In the variables.tf file, define your variables, such as VPC CIDR block, subnet CIDR blocks, availability zones, and AWS region. Modify these variables to match your requirements.

### 3. Makefile
We have included a Makefile for simplifying Terraform operations. Use the following commands:

make init: Initialize Terraform in the terraform directory.
make plan: Create an execution plan to review changes.
make apply: Apply the Terraform configuration to create AWS resources.
make destroy: Destroy AWS resources created by Terraform (use with caution).
5. Terraform Commands
If you prefer running Terraform commands directly, navigate to the terraform directory and run:

```bash
terraform init
terraform plan
terraform apply
```

### 7. Clean Up
After you're finished, use make destroy or terraform destroy to remove the created AWS resources.

