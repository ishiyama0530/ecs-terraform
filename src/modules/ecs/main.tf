resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"

  tags = {
    Name = "${var.app_name}-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
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
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : "firelens-container",
          "awslogs-region" : var.region,
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" : "firelens"
        }
      }
    }
  ])

  tags = {
    Name = "${var.app_name}-ecs-task-definition"
  }
}

resource "aws_ecs_service" "app" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

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
