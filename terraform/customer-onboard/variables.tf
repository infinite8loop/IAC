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
  default     = "ez-ai-ecs"
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
  default     = "vpc-00f5026452eba24f9"
  description = "Id of vpc network"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "type of environmemnt"
}

variable "private_subnets_ids" {
  type        = list(string)
  default     = ["subnet-057a35ce54df32ebd", "subnet-01a5fc5b2bfea4431"]
  description = "private_subnets_ids"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "private_subnets_cidr"
}

variable "public_subnets_ids" {
  type        = list(string)
  default     = ["subnet-0cc5bff73708e06d4", "subnet-068511e19ec26cf96"]
  description = "public_subnets_ids"
}


variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  description = "public_subnets_cidr"
}

