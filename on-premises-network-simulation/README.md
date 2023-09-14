# 2.On Premises Network Simulation

For the sake of the dfjdsaiophjodshof;dsjf;

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS CLI configured with necessary access and secret keys.

## Usage

### 1. Clone the Repository

```bash
git clone <repository-url>
cd <repository-directory>
```

### 2. Create a terraform Directory
Create a terraform directory within the repository to organize your Terraform configuration files. Inside this directory, place your Terraform configuration files, such as main.tf, variables.tf, and terraform.tfvars (if needed).

### 3. Define Variables
In the variables.tf file, define your variables, such as VPC CIDR block, subnet CIDR blocks, availability zones, and AWS region. Modify these variables to match your requirements.

### 4. Makefile
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

### 6. Review and Confirm
Review the Terraform plan output before applying changes. Confirm by typing "yes" when prompted.

### 7. Clean Up
After you're finished, use make destroy or terraform destroy to remove the created AWS resources.

