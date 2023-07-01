resource "aws_globalaccelerator_accelerator" "this" {
  name            = var.app_name
  enabled         = true
  ip_address_type = "IPV4"

  tags = {
    Name = "${var.app_name}-globalaccelerator"
  }
}

resource "aws_globalaccelerator_listener" "http" {
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "http" {
  listener_arn          = aws_globalaccelerator_listener.http.id
  endpoint_group_region = var.region

  health_check_protocol         = "HTTP"
  health_check_path             = "/"
  health_check_port             = 80
  health_check_interval_seconds = 30
  threshold_count               = 2

  endpoint_configuration {
    endpoint_id                    = var.lb_arn
    weight                         = 100
    client_ip_preservation_enabled = true
  }
}

resource "aws_globalaccelerator_listener" "https" {
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 443
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "https" {
  listener_arn          = aws_globalaccelerator_listener.https.id
  endpoint_group_region = var.region

  health_check_protocol         = "HTTPS"
  health_check_path             = "/"
  health_check_port             = 443
  health_check_interval_seconds = 30
  threshold_count               = 2

  endpoint_configuration {
    endpoint_id                    = var.lb_arn
    weight                         = 100
    client_ip_preservation_enabled = true
  }
}
