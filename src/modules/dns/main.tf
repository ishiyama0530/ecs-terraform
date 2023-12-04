data "aws_route53_zone" "zone" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "a_record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    zone_id                = var.lb_zone_id
    name                   = var.lb_dns_name
    evaluate_target_health = true
  }
}
