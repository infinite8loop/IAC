#############################################################
# Variable Defenitions
#############################################################


variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Ipv4 CIDR of vpc network"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "availability_zones"
}