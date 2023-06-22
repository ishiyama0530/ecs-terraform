resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    zone_id                = var.globalaccelerator_zone_id
    name                   = var.globalaccelerator_name
    evaluate_target_health = true
  }
}
