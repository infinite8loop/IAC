#############################################################
# Variable Defenitions
#############################################################

variable "region" {
  type        = string
  default     = "us-west-1"
  description = "AWS Region"
}

#############################################################
# VPC & Subnets Variables 
#############################################################

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Ipv4 CIDR of vpc network"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "type of environmemnt"
}


variable "availability_zones" {
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
  description = "availability_zones"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "private_subnets"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  description = "public_subnets"
}

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