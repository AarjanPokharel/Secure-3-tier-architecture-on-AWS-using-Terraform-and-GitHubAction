# Secure-3-tier-architecture-on-AWS-using-Terraform-and-GitHubAction

This project establishes a secure 3-tier infrastructure on AWS using Terraform and GitHub Actions. It involves creating a VPC, along with a public subnet and two private subnets in different AZs and their respective routing tables. An Internet Gateway is implemented for the public subnet, complemented by a NAT Gateway with an Elastic IP to enable outbound internet access for the private subnet. Additionally, an Amazon RDS instance running MySQL is deployed in the private subnet, accessible only from a private EC2 instance. For the application layer, a private EC2 instance is set up without a public IP, while a public EC2 instance is created in the public subnet to serve as the web layer with a public IP. Security is enhanced through the configuration of security groups to manage traffic at the instance level. A GitHub Actions Workflow is then defined to automate the process of deploying the mentioned AWS infrastructure.



WHAT HAS BEEN ACCOMPLISHED:
----------------------

1. Created AWS infrastructure using terraform, which includes:
- a VPC
- a public subnet and two private subnets in different AZs
- an internet gateway
- route table and its association for internet connection
- an elastic IP
- a NAT gateway
- two ec2 instances
- MySQL RDS database instance
- security groups to attach to ec2 instance and the rds instance

2. Developed a GitHub Action Workflow to deploy the infrastructure defined via terraform code to AWS
