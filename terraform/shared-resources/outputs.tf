################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = ""
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = ""
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = ""
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = ""
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = ""
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets_cidr_blocks" {
  description = ""
  value       = module.vpc.private_subnets_cidr_blocks
}
