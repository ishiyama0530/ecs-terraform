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

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "cert_arn" {
  type = string
}
