module "account_id_getter" {
  source = "../../lib/account_id_getter"
}

module "identity_generator" {
  source = "../../lib/identity_generator"

  region   = var.region
  app_name = var.app_name
}

module "entrypoint" {
  source = "../../modules"

  account_id  = module.account_id_getter.value
  identity    = module.identity_generator.value
  profile     = var.profile
  region      = var.region
  app_name    = var.app_name
  vpc         = var.vpc
  subnets     = var.subnets
  zone_id     = var.zone_id
  domain_name = var.domain_name
  cert_arn    = var.cert_arn
}
