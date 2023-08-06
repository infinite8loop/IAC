#############################################################
# VPC Defenitions
#############################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-name"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true  

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

