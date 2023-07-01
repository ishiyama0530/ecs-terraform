terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.4.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region

  default_tags {
    tags = {
      "ManagedBy" = "Terraform"
      "CreatedBy" = var.account_id
      "Identity"  = var.identity
    }
  }
}
