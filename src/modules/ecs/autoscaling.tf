resource "aws_appautoscaling_target" "ecs" {
  max_capacity       = 5
  min_capacity       = 2
  resource_id        = "service/${var.app_name}-ecs-cluster/${var.app_name}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  tags = {
    Name = "${var.app_name}-ecs-asg"
  }

  depends_on = [
    aws_ecs_service.service
  ]
}

resource "aws_appautoscaling_policy" "ecs" {
  name               = "${var.app_name}-ecs-asg-policy-cpu75"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 75
    scale_out_cooldown = 60
    scale_in_cooldown  = 60
  }
}
