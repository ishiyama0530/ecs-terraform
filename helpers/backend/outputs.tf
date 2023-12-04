output "region" {
  value       = aws_s3_bucket.terraform_state.region
  description = "value of backend s3 region"
}

output "bucket" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "value of backend s3 bucket"
}
