module "entrypoint" {
  source = "../../"

  account_id  = local.account_id
  identity    = local.identity
  profile     = var.profile
  region      = var.region
  app_name    = var.app_name
  vpc         = var.vpc
  subnets     = var.subnets
  domain_name = var.domain_name
}
