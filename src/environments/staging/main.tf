module "entrypoint" {
  source = "../../"

  account_id  = local.account_id
  identity    = local.identity
  profile     = var.profile
  region      = var.region
  app_name    = var.app_name
  vpc         = var.vpc
  subnets     = var.subnets
  zone_id     = var.zone_id
  domain_name = var.domain_name
  cert_arn    = var.cert_arn
}
