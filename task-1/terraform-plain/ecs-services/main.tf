provider "aws" {
    region = var.region
    profile = var.profile
}

resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress"
  cluster         = var.ecs_cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups = var.ecs_sg_id
  }
  load_balancer {
    target_group_arn = var.wordpress_target_group_arn
    container_name   = var.wordpress_container_name
    container_port   = 80
  }

  #  Auto Scaling
  deployment_controller {
    type = "ECS"
  }
}

resource "aws_appautoscaling_target" "wordpress_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.wordpress_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "wordpress_cpu_policy" {
  name               = "wordpress-cpu-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.wordpress_target.resource_id
  scalable_dimension = aws_appautoscaling_target.wordpress_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.wordpress_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 50
  }
}

resource "aws_appautoscaling_policy" "wordpress_memory_policy" {
  name               = "wordpress-memory-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.wordpress_target.resource_id
  scalable_dimension = aws_appautoscaling_target.wordpress_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.wordpress_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 50
  }
}


# node-microservice

resource "aws_ecs_service" "nodejs_service" {
  name            = "nodejs-microservice"
  cluster         = var.ecs_cluster_id
  task_definition = var.microservice_task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups = var.ecs_sg_id
  }
  load_balancer {
    target_group_arn = var.microservice_target_group_arn
    container_name   = "microservice-container"
    container_port   = 3000
  }


  #  Auto Scaling
  deployment_controller {
    type = "ECS"
  }
}
