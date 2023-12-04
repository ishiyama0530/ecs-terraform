resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.app_name}-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task.arn

  container_definitions = jsonencode([
    {
      name : var.app_name,
      image : "nginx:latest",
      essential : true,
      portMappings : [
        {
          protocol : "tcp",
          containerPort : 80,
          hostPort : 80,
        }
      ],
      healthCheck : {
        command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 30
      },
      logConfiguration : {
        logDriver : "awsfirelens",
        options : {
          "Name" : "cloudwatch",
          "auto_create_group" : "true"
          "log_group_name" : "/aws/ecs/containerinsights/${var.app_name}-cluster/application",
          "log_stream_prefix" : "ecs/",
          "region" : var.region,
        }
      }
    },
    {
      name : "log_router",
      image : "906394416424.dkr.ecr.${var.region}.amazonaws.com/aws-for-fluent-bit:stable",
      essential : true,
      user : "0", # これがないと毎回 terraform apply でタスクの再定義が実行されてしまう
      firelensConfiguration : {
        type : "fluentbit"
      },
      healthCheck : {
        command     = ["CMD-SHELL", "pgrep fluent-bit || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 30
      },
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : "firelens-container",
          "awslogs-region" : var.region,
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" : "firelens"
        }
      },
    }
  ])

  tags = {
    Name = "${var.app_name}-ecs-task-definition"
  }
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  propagate_tags  = "SERVICE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.app_name
    container_port   = 80
  }
}
