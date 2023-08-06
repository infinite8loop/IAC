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
  default     = "ecs"
  description = "Name of ECS"
}

###VPC-ECS

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Ipv4 CIDR of vpc network"
}

variable "vpc_id" {
  type        = string
  default     = ""
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

