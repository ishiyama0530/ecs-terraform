locals {
  identity = sha256("${var.region}-${var.app_name}")
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
  description = "value of Application Name"
}

variable "account_id" {
  type        = string
  description = "get by `$ aws sts get-caller-identity --query Account --output text`"
}
