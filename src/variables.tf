variable "account_id" {
  type = string
}

variable "identity" {
  type = string
}

variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "vpc" {
  type = object({
    cidr = string
  })
}

variable "subnets" {
  type = list(object({
    private_subnet_cidr = string,
    public_subnet_cidr  = string,
  }))
}

variable "domain_name" {
  type = string
}
