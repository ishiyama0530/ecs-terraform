data "aws_caller_identity" "self" {}

locals {
  account_id = data.aws_caller_identity.self.account_id
  identity   = sha256("${var.region}-${var.app_name}")
}

variable "profile" {
  type        = string
  default     = "default"
  description = "value of AWS_PROFILE"
}

variable "region" {
  type        = string
  default     = "ap-northeast-1"
  description = "value of AWS_REGION"
}

variable "app_name" {
  type        = string
  default     = "staging-web-app"
  description = "value of Application Name"
}

variable "vpc" {
  type = object({
    cidr = string
  })
  default = {
    cidr = "10.0.0.0/20"
  }
  description = "value of VPC CIDR"
}

variable "subnets" {
  type = list(object({
    private_subnet_cidr = string,
    public_subnet_cidr  = string,
  }))
  default = [
    {
      private_subnet_cidr = "10.0.0.0/24"
      public_subnet_cidr  = "10.0.1.0/26"
    },
    {
      private_subnet_cidr = "10.0.2.0/24"
      public_subnet_cidr  = "10.0.3.0/26"
    },
    {
      private_subnet_cidr = "10.0.4.0/24"
      public_subnet_cidr  = "10.0.5.0/26"
    }
  ]
  description = "value of Subnets CIDR"
}

variable "domain_name" {
  type        = string
  description = "value of Route53 Domain Name"
}
