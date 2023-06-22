module "account_id_getter" {
  source = "./lib/account_id_getter"
}

module "identity_generator" {
  source = "./lib/identity_generator"

  region   = var.region
  app_name = var.app_name
}

module "network" {
  source = "./modules/network"

  profile    = var.profile
  region     = var.region
  app_name   = var.app_name
  account_id = module.account_id_getter.value
  identity   = module.identity_generator.value
  vpc        = var.vpc
  subnets    = var.subnets
}

module "alb" {
  source = "./modules/alb"

  profile    = var.profile
  region     = var.region
  app_name   = var.app_name
  account_id = module.account_id_getter.value
  identity   = module.identity_generator.value
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.lb_subnet_ids
}

module "globalaccelerator" {
  source = "./modules/globalaccelerator"

  profile    = var.profile
  region     = var.region
  app_name   = var.app_name
  account_id = module.account_id_getter.value
  identity   = module.identity_generator.value
  lb_arn     = module.alb.alb_arn
}

module "route53" {
  source = "./modules/route53"

  profile                   = var.profile
  region                    = var.region
  app_name                  = var.app_name
  account_id                = module.account_id_getter.value
  identity                  = module.identity_generator.value
  zone_id                   = var.zone_id
  domain_name               = var.domain_name
  cert_arn                  = var.cert_arn
  globalaccelerator_name    = module.globalaccelerator.dns_name
  globalaccelerator_zone_id = module.globalaccelerator.hosted_zone_id
}

module "ecs" {
  source = "./modules/ecs"

  profile              = var.profile
  region               = var.region
  app_name             = var.app_name
  account_id           = module.account_id_getter.value
  identity             = module.identity_generator.value
  vpc_id               = module.network.vpc_id
  subnet_ids           = module.network.private_subnet_ids
  lb_security_group_id = module.alb.security_group_id
  lb_target_group_arn  = module.alb.target_group_arn
}
