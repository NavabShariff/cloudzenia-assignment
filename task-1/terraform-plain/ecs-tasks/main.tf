provider "aws" {
    region = var.region
    profile = var.profile
}

data "aws_secretsmanager_secret" "rds_credentials" {
  name = var.aws_secret_id
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = var.cloudwatch_log_group
  retention_in_days = var.log_retention_period
}


resource "aws_ecs_task_definition" "wordpress_task_definition" {
  family                   = var.wordpress_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu_wordpress
  memory                   = var.memory_wordpress
  execution_role_arn       = var.ecs_task_execution_role
  task_role_arn            = var.ecs_task_role

  container_definitions = jsonencode([
    {
      name      = var.wordpress_container_name
      image     = var.wordpress_container_image
      portMappings = [
        {
          containerPort = var.wordpress_container_port
          hostPort      = var.wordpress_container_host_port
        }
      ]
      environment = []
      secrets = [
        {
          name      = "WORDPRESS_DB_HOST"
          valueFrom = "${data.aws_secretsmanager_secret.rds_credentials.arn}:host::"
        },
        {
          name      = "WORDPRESS_DB_USER"
          valueFrom = "${data.aws_secretsmanager_secret.rds_credentials.arn}:username::"
        },
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = "${data.aws_secretsmanager_secret.rds_credentials.arn}:password::"
        },
        {
          name      = "WORDPRESS_DB_NAME"
          valueFrom = "${data.aws_secretsmanager_secret.rds_credentials.arn}:dbname::"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.cloudwatch_log_group
          awslogs-region        = var.region
          awslogs-stream-prefix = var.cloudwatch_log_stream_prefix
        }
      }
    }
  ])
}

# nodejs-microservice

resource "aws_ecs_task_definition" "microservice_task" {
  family                   = "nodejs-microservice"
  execution_role_arn       = var.ecs_task_execution_role
  task_role_arn            = var.ecs_task_role
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "microservice-container"
      image     = var.microservice_image_url
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.cloudwatch_log_group
          awslogs-region        = var.region
          awslogs-stream-prefix = "nodejs-microservice"
        }
      }
    }
  ])
}
