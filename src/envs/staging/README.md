# ECS-TERRAFORM/STAGING

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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_entrypoint"></a> [entrypoint](#module\_entrypoint) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | value of Application Name | `string` | `"your-app"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | value of Route53 Domain Name | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | value of AWS\_PROFILE | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | value of AWS\_REGION | `string` | `"ap-northeast-1"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | value of Subnets CIDR | <pre>list(object({<br>    private_subnet_cidr = string,<br>    public_subnet_cidr  = string,<br>  }))</pre> | <pre>[<br>  {<br>    "private_subnet_cidr": "10.0.0.0/24",<br>    "public_subnet_cidr": "10.0.1.0/26"<br>  },<br>  {<br>    "private_subnet_cidr": "10.0.2.0/24",<br>    "public_subnet_cidr": "10.0.3.0/26"<br>  },<br>  {<br>    "private_subnet_cidr": "10.0.4.0/24",<br>    "public_subnet_cidr": "10.0.5.0/26"<br>  }<br>]</pre> | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | value of VPC CIDR | <pre>object({<br>    cidr = string<br>  })</pre> | <pre>{<br>  "cidr": "10.0.0.0/20"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->