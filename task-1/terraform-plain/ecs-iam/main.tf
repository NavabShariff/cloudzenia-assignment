provider "aws" {
  profile = var.profile
  region  = var.region
}


data "aws_secretsmanager_secret" "rds_credentials" {
  name = var.aws_secret_id
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_secrets_policy" {
  name        = "ecs-secrets-policy"
  description = "Allows ECS tasks to access AWS Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"  
        ],
        Effect = "Allow",
        Resource = [
          data.aws_secretsmanager_secret.rds_credentials.arn,
          "arn:aws:secretsmanager:${var.region}:*:secret/${data.aws_secretsmanager_secret.rds_credentials.name}*"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_secret_policy_attachment" {
  role  = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_secrets_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment_" {
  role  = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com" 
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_task_role_secret_policy_attachment" {
  role  = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_secrets_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role  = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}