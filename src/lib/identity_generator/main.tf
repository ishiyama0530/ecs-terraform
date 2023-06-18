variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

output "value" {
  value = sha256("${var.region}-${var.app_name}")
}
