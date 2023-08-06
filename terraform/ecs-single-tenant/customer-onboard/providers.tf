provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  cloud {
    organization = "t-cloud-organization-name"

    workspaces {
      name = "t-cloud-workspace-name"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.3"
}


#For multiple customers
/* provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  backend "remote" {
    organization = "t-cloud-organization-name"

    workspaces {
      prefix = "onboarding-customer-"  #onboarding-customer-<CUSTOMER_NAME>
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.0"
    }
  }
  required_version = ">= 1.2.3"
} */