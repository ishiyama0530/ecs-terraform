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
    lb_subnet_cidr      = string,
    nat_subnet_cidr     = string,
  }))
}

