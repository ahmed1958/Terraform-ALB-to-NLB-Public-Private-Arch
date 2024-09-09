# Terraform-ALB-to-NLB-Public-Private-Arch
This project implements a public-private architecture on AWS using Terraform. It uses an Application Load Balancer (ALB) for public-facing traffic, which directs requests to a public EC2S which direct requests to a Network Load Balancer (NLB) for private resources, such as EC2 instances hosted in a Virtual Private Cloud (VPC). The infrastructure is designed to be highly available and scalable.

## Project Structure
``` sh 
.
├── configuration.tf             # Global configuration for the project (e.g., backend settings)
├── main.tf                      # Main entry point for the infrastructure definition
├── nginx.conf                   # NGINX configuration for EC2 instances
├── output.tf                    # Defines the output variables from the deployment
├── provider.tf                  # AWS provider and authentication setup
├── values.auto.tfvars           # Default values for input variables
├── variables.tf                 # Defines input variables used in the project
├── EC2_module/                  # EC2 instance resources
│   ├── main.tf                  # EC2 instance definitions
│   ├── outputs.tf               # Outputs specific to EC2 instances (e.g., instance IDs)
│   └── variables.tf             # Variables specific to EC2 instances (e.g., AMI ID, instance type)
├── VPC_module/                  # VPC and network resources
│   ├── main.tf                  # VPC creation, subnets, internet gateway, route tables
│   ├── outputs.tf               # Outputs related to VPC (e.g., subnet IDs, VPC ID)
│   └── variables.tf             # Variables for VPC settings (e.g., CIDR blocks)
├── loadbalancer/                # Load Balancer resources (ALB and NLB)
│   ├── main.tf                  # ALB and NLB definitions, listener rules, target groups
│   ├── output.tf                # Output values for the load balancer (e.g., DNS name)
│   └── variable.tf              # Variables for the load balancer module (e.g., ports, target groups)
└── .gitignore                   # Git ignore file for untracked files (e.g., state files)
 ```
