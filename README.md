# Terraform VPC Module

This Terraform module creates a VPC with public and private subnets, an Internet Gateway, and an EC2 instance. It also sets up security groups to allow SSH and HTTP access.

## Table of Contents

- [Requirements](#requirements)
- [Inputs](#inputs)
  - [Required Inputs](#required-inputs)
  - [Optional Inputs](#optional-inputs)
- [Outputs](#outputs)
- [Usage](#usage)
- [License](#license)

## Requirements

- Terraform 5.0 or more
- AWS Provider

## Inputs

### Required Inputs

- `vpc_cidr_block` (string): The CIDR block for the VPC.
- `vpc_name` (string): The name tag for the VPC.
- `igw_name` (string): The name tag for the Internet Gateway.
- `public_subnet_cidr_block` (string): The CIDR block for the public subnet.
- `public_subnet_name` (string): The name tag for the public subnet.
- `private_subnet_cidr_block` (string): The CIDR block for the private subnet.
- `private_subnet_name` (string): The name tag for the private subnet.
- `ami_id` (string): The AMI ID for the EC2 instance.
- `instance_type` (string): The type of the EC2 instance.
- `instance_name` (string): The name tag for the EC2 instance.

### Optional Inputs

- `public_rt_name` (string, default: `"public_rt"`): The name tag for the public route table.
- `sg_name` (string, default: `"week4_public_sg"`): The name tag for the security group.
- `private_rt_name` (string, default: `"private_rt"`): The name tag for the private route table.
- `sg_description` (string, default: `"Public sg to allow ssh and https from internet"`): Description of the security group.
- `public_subnet_availability_zone` (string, default: `"us-east-1a"`): The availability zone for the public subnet.
- `private_subnet_availability_zone` (string, default: `"us-east-1b"`): The availability zone for the private subnet.

## Outputs

- `ec2_id`: The ID of the created EC2 instance.
- `sg_id`: The ID of the created security group.

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "week4_vpc_test" {
  source = "git::https://github.com/jagadeesh619/week4-vpc-module.git"

  vpc_cidr_block             = "10.0.0.0/16"
  vpc_name                   = "week4_vpc"
  igw_name                   = "week4_igw"
  public_subnet_cidr_block   = "10.0.1.0/24"
  public_subnet_name         = "public_subnet"
  private_subnet_cidr_block  = "10.0.11.0/24"
  private_subnet_name        = "private_subnet"
  ami_id                     = "ami-0182f373e66f89c85"
  instance_type              = "t2.micro"
  instance_name              = "week4_ec2"
}

