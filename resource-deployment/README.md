# 4.Resource Deployment & Network Access Control
 - Now its time to deploy test resources (like VMs) in each subnet of your main Azure VNet. For instance, deploy a web server VM in the WebApp Subnet, a database in the Database Subnet, etc.

- This repository contains Terraform configurations to automate the creation of AWS infrastructure. It includes the setup 2 EC-2 instances and 2 RDS instances different subnets(private) and availability zones.

## What's being created:

- VPC called "network-sim-office-vpc" of CIDR 19.0.0.0/16

- EC-2 Instance called "web-app-1" on "network-sim-office-private-web-app-1-subnet-us-east-1a"

- EC-2 Instance called "web-app-2" on "network-sim-office-private-web-app-2-subnet-us-east-1b"

- RDS Instance called "data-1" on "network-sim-office-private-data-1-subnet-us-east-1a"

- RDS Instance called "data-2" on "network-sim-office-private-data-2-subnet-us-east-1b"

## Prerequisites
Make sure you have Terraform installed and you configured your aws cli, and stored your access-key and secret-access-key locally in your .env
Also make a .pem key-pair called "all-projects" and store it locally as well(useful for next steps)

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