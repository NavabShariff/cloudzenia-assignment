variable region {
  type        = string
  default     = "ap-south-1"
}

variable profile {
  type        = string
  default     = "default"
}


variable ecs_cluster_id {
  type        = string
  default     = "arn:aws:ecs:ap-south-1:096803082364:cluster/cloudzenia"
}

variable ecs_cluster_name {
  type        = string
  default     = "cloudzenia"
}


variable task_definition_arn {
  type        = string      
  default     = "arn:aws:ecs:ap-south-1:096803082364:task-definition/wordpress:14"
}


variable desired_count {
  type        = number
  default     = "1"
}


variable private_subnet_ids {
  type        = list(string)
  default     = ["subnet-0d0dff24fea104067", "subnet-03db8770304b5a2de"]
}

variable ecs_sg_id {
  type        = list(string)
  default     = ["sg-07425815dd56d57f4"]
}


variable wordpress_target_group_arn {
  type        = string
  default     = "arn:aws:elasticloadbalancing:ap-south-1:096803082364:targetgroup/wordpress-target-gp/d8e9dcc0136df318"
}

variable wordpress_container_name {
  type        = string
  default     = "wordpress"
}

variable microservice_task_definition_arn {
  type        = string
  default     = "arn:aws:ecs:ap-south-1:096803082364:task-definition/nodejs-microservice:4"
  description = "description"
}

variable microservice_target_group_arn {
  type        = string
  default     = "arn:aws:elasticloadbalancing:ap-south-1:096803082364:targetgroup/nodjs-microservice-target-gp/879e585647d436f5"
  description = "description"
}
