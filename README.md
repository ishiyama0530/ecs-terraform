# ecs-terraform

Create backend s3

```bash
# Move work directory
$ cd helpers/backend

# Initialize
$ terraform init

# Resource Apply
$ terraform apply -var="app_name=your-app" -var="account_id=$(aws sts get-caller-identity --query Account --output text)"

# Resource Destroy
$ terraform destroy -var="app_name=your-app" -var="account_id=$(aws sts get-caller-identity --query Account --output text)"
```

Modify backend.tf to match the backend file you created.

```bash
# src/envs/staging/backend.tf
terraform {
  backend "s3" {
    bucket = "terraform-state-your-app"
    region = "ap-northeast-1"
    key    = "terraform-state-your-app/terraform.tfstate"
  }
}
```

Apply terraform

```bash
# Move work directory
$ cd src/envs/staging

# backend.tf

# Initialize
$ terraform init

# Resource Apply
$ terraform apply -var="domain_name=example.com"

# Resource Destroy
$ terraform destroy -var="domain_name=example.com"
```

Execute utilities

```bash
# Pre-commit checks
$ sh scripts/pre-commit.sh
```
