output wordpress_task_arn {
  value       = aws_ecs_task_definition.wordpress_task_definition.arn
  sensitive   = false
  description = "description"
  depends_on  = []
}

output microservice_task_arn {
  value       = aws_ecs_task_definition.microservice_task.arn
  sensitive   = false
  description = "description"
  depends_on  = []
}