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

