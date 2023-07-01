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

variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cert_arn" {
  type = string
}

variable "globalaccelerator_name" {
  type = string
}

variable "globalaccelerator_zone_id" {
  type = string
}
