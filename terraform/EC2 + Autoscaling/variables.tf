variable "aws_access_key" {
  type        = string
  default     = "<key>"
  description = "access_key"
}

variable "aws_secret_key" {
  type        = string
  default     = "<key>"
  description = "secret_key"
}

variable "region" {
  type        = string
  default     = "us-west-1"
  description = "AWS Region"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
  description = "availability_zones"
}

variable "name" {
  type        = string
  default     = "<>"
  description = "Name of EC2"
}

###VPC-ECS

variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "Ipv4 CIDR of vpc network"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-"
  description = "Id of vpc network"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "type of environmemnt"
}

variable "private_subnets_ids" {
  type        = list(string)
  default     = ["", ""]
  description = "private_subnets_ids"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["", ""]
  description = "private_subnets_cidr"
}

variable "public_subnets_ids" {
  type        = list(string)
  default     = ["", ""]
  description = "public_subnets_ids"
}


variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["", ""]
  description = "public_subnets_cidr"
}

variable "ec2_user_data" {
  type        = string
  default     = <<EOF
#!/bin/bash

# Install Docker on Ubuntu
sudo $(aws ecr get-login --no-include-email --region us-east-1)
sudo docker run  --platform linux/amd64 -p 8001:8001 -e MONGO_DB="ez_ai" -e MONGO_URI="" -e  MILVUS_HOST="" -e MILVUS_PORT="19530"   302220238753.dkr.ecr.us-east-1.amazonaws.com/inference
EOF
}