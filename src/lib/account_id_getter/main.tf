terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.4.0"
    }
  }
}

data "aws_caller_identity" "self" {}

output "value" {
  value = data.aws_caller_identity.self.account_id
}
