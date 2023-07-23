#############################################################
# VPC Defenitions
#############################################################

module "vpc" {
  source = "cloudposse/vpc/aws"

  version = "2.0.0"
#   stage   = var.stage
  name    = "Ez-ai-vpc"
  environment = var.environment
  ipv4_primary_cidr_block = var.vpc_cidr

  assign_generated_ipv6_cidr_block = false

}