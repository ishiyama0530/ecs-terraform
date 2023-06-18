resource "aws_security_group" "ecs" {
  name        = "${var.app_name}-ecs"
  description = "ECS security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [var.lb_security_group_id]
    description     = "Allow HTTP from LB"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.app_name}-ecs-security-group"
  }
}
