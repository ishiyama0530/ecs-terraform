resource "aws_iam_role" "task" {
  name = "${var.app_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          Service : "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.app_name}-ecs-task-role"
  }
}

resource "aws_iam_policy" "task" {
  name = "${var.app_name}-ecs-task-policy"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "ecs:*",
          "cloudwatch:*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "*"
      }
    ]
  })

  tags = {
    Name = "${var.app_name}-ecs-task-policy"
  }
}

resource "aws_iam_role_policy_attachment" "task" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.task.arn
}
