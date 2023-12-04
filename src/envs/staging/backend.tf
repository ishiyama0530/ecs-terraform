terraform {
  backend "s3" {
    bucket = "terraform-state-staging-web-app"
    region = "ap-northeast-1"
    key    = "terraform-state-staging-web-app/terraform.tfstate"
  }
}
