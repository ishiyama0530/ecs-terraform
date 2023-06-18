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

variable "account_id" {
  type = string
}

variable "identity" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
