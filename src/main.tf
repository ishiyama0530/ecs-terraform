module "network" {
  source = "./modules/network"

  app_name = var.app_name
  vpc      = var.vpc
  subnets  = var.subnets
}

module "dns" {
  source = "./modules/dns"

  domain_name = var.domain_name
  lb_dns_name = module.loadbalancer.dns_name
  lb_zone_id  = module.loadbalancer.zone_id
}

module "ssl" {
  source = "./modules/ssl"

  app_name    = var.app_name
  domain_name = var.domain_name
}

module "ecs" {
  source = "./modules/ecs"

  region               = var.region
  app_name             = var.app_name
  vpc_id               = module.network.vpc_id
  subnet_ids           = module.network.private_subnet_ids
  lb_security_group_id = module.loadbalancer.security_group_id
  lb_target_group_arn  = module.loadbalancer.target_group_arn
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  app_name   = var.app_name
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids
  cert_arn   = module.ssl.cert_arn
}
