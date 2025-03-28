variable "profile" {
  type        = string
  default     = "default"
}

variable "region" {
  type        = string
  default     = "ap-south-1"
}

variable "ecs_task_role_name" {
  type        = string
  default     = "ecsTaskRole"
}

variable "ecs_task_execution_role_name" {
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable policy_arn {
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}


variable aws_db_secret_arn {
  type        = string
  default     = "arn:aws:secretsmanager:ap-south-1:096803082364:secret:wordpress-secrets-7iGlyd"
  description = "description"
}

variable aws_secret_id {
  type        = string
  default     = "wordpress-secrets"
  description = "description"
}
