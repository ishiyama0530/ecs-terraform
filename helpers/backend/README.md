# ECS-TERRAFORM/BACKEND

Execution command

```bash
$ terraform init

$ terraform apply -var="app_name=staging-web-app" -var="account_id=$(aws sts get-caller-identity --query Account --output text)"

$ terraform destroy -var="app_name=staging-web-app" -var="account_id=$(aws sts get-caller-identity --query Account --output text)"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | get by `$ aws sts get-caller-identity --query Account --output text` | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | value of Application Name | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | value of AWS\_PROFILE | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | value of AWS\_REGION | `string` | `"ap-northeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | value of backend s3 bucket |
| <a name="output_region"></a> [region](#output\_region) | value of backend s3 region |
<!-- END_TF_DOCS -->