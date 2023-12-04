# ECS-TERRAFORM/STAGING

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

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
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | value of Application Name | `string` | `"StagingWebApp"` | no |
| <a name="input_cert_arn"></a> [cert\_arn](#input\_cert\_arn) | value of ACM Certificate ARN | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | value of Route53 Domain Name | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | value of AWS\_PROFILE | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | value of AWS\_REGION | `string` | `"ap-northeast-1"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | value of Subnets CIDR | <pre>list(object({<br>    private_subnet_cidr = string,<br>    lb_subnet_cidr      = string,<br>    nat_subnet_cidr     = string,<br>  }))</pre> | <pre>[<br>  {<br>    "lb_subnet_cidr": "10.0.1.0/26",<br>    "nat_subnet_cidr": "10.0.1.64/28",<br>    "private_subnet_cidr": "10.0.0.0/24"<br>  },<br>  {<br>    "lb_subnet_cidr": "10.0.3.0/26",<br>    "nat_subnet_cidr": "10.0.3.64/28",<br>    "private_subnet_cidr": "10.0.2.0/24"<br>  },<br>  {<br>    "lb_subnet_cidr": "10.0.5.0/26",<br>    "nat_subnet_cidr": "10.0.5.64/28",<br>    "private_subnet_cidr": "10.0.4.0/24"<br>  }<br>]</pre> | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | value of VPC CIDR | <pre>object({<br>    cidr = string<br>  })</pre> | <pre>{<br>  "cidr": "10.0.0.0/20"<br>}</pre> | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | value of Route53 Hosted Zone ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | value of Load Balancer DNS Name |
| <a name="output_lb_subnet_ids"></a> [lb\_subnet\_ids](#output\_lb\_subnet\_ids) | value of Load Balancer Subnets ID |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | value of Private Subnets ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | value of VPC ID |
<!-- END_TF_DOCS -->