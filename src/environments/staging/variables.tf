data "aws_caller_identity" "self" {}

locals {
  account_id = data.aws_caller_identity.self.account_id
  identity   = sha256("${var.region}-${var.app_name}")
}

variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "app_name" {
  type    = string
  default = "StagingWebApp"
}

variable "vpc" {
  type = object({
    cidr = string
  })
  default = {
    cidr = "10.0.0.0/20"
  }
}

variable "subnets" {
  type = list(object({
    private_subnet_cidr = string,
    lb_subnet_cidr      = string,
    nat_subnet_cidr     = string,
  }))
  default = [
    {
      private_subnet_cidr = "10.0.0.0/24"
      lb_subnet_cidr      = "10.0.1.0/26"
      nat_subnet_cidr     = "10.0.1.64/28"
    },
    {
      private_subnet_cidr = "10.0.2.0/24"
      lb_subnet_cidr      = "10.0.3.0/26"
      nat_subnet_cidr     = "10.0.3.64/28"
    },
    {
      private_subnet_cidr = "10.0.4.0/24"
      lb_subnet_cidr      = "10.0.5.0/26"
      nat_subnet_cidr     = "10.0.5.64/28"
    }
  ]
}

variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cert_arn" {
  type = string
}
