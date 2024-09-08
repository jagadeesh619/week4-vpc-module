variable "vpc_cidr_block" {
      type=string
}

variable "vpc_name" {
      type=string
}

variable "igw_name" {
      type=string
}

variable "public_subnet_cidr_block" {
      type=string
}

variable "public_subnet_name" {
      type=string
}

variable "private_subnet_cidr_block" {
      type=string
}

variable "private_subnet_name" {
      type=string
}

variable "ami_id" {
      type=string
}

variable "instance_type" {
      type=string
}

variable "instance_name" {
      type=string
}

variable "public_rt_name" {
      type=string
       default="public_rt"
}

variable "sg_name" {
      type=string
       default="week4_public_sg"
}

variable "private_rt_name" {
      type=string
       default="private_rt"
}
variable "sg_description" {
     type= string
     default = "Public sg to allow ssh and https from internet"
}
variable "public_subnet_availability_zone" {
      default = "us-east-1a"
}
variable "private_subnet_availability_zone" {
      default = "us-east-1b"
}
