provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  cloud {
    organization = "Ez-ai"

    workspaces {
      name = "customer-1"
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
    organization = "Ez-ai"

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