variable region {
  type        = string
  default     = "ap-south-1"
}

variable profile {
  type        = string
  default     = "default"
}

variable wordpress_family_name {
  type        = string
  default     = "wordpress"
}


variable ecs_task_execution_role {
  type        = string
  default     = "arn:aws:iam::096803082364:role/ecsTaskExecutionRole"
}

variable ecs_task_role {
  type        = string
  default     = "arn:aws:iam::096803082364:role/ecsTaskRole"
}


variable wordpress_container_name {
  type        = string
  default     = "wordpress"
}

variable cpu_wordpress {
  type        = number
  default     = "256"
}

variable memory_wordpress {
  type        = number
  default     = "512"
}

variable wordpress_container_port {
  type        = number
  default     = "80"
}

variable wordpress_container_host_port {
  type        = number
  default     = "80"
}

variable wordpress_container_image {
  type        = string
  default     = "wordpress"
}

variable aws_secret_id {
  type        = string
  default     = "wordpress-secrets"
}

variable "cloudwatch_log_group" {
  type        = string
  description = "CloudWatch log group name for ECS logs"
  default     = "/ecs/wordpress"
}

variable "cloudwatch_log_stream_prefix" {
  type        = string
  description = "CloudWatch log stream prefix"
  default     = "wordpress"
}

variable log_retention_period {
  type        = string
  default     = "3"
}

variable microservice_image_url {
  type        = string
  default     = "096803082364.dkr.ecr.ap-south-1.amazonaws.com/cloudzenia:nodejs-microservice-a2e75bfc"
  description = "description"
}
