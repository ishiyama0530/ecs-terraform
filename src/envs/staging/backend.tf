terraform {
  backend "s3" {
    bucket = "terraform-state-your-app"
    region = "ap-northeast-1"
    key    = "terraform-state-your-app/terraform.tfstate"
  }
}
