variable "region" {
  type        = string
  default     = "ap-south-1"
}

variable "profile" {
  type        = string
  default     = "default"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0dbb3ff386dd563ff"
}

variable "alb_sg_id" {
  type        = list(string)
  default     = ["sg-00615dbeb52117195"]
}


variable "public_subnet_ids" {
  type        = list(string)
  default     = ["subnet-031552e2504d520d3", "subnet-038451eb411146ad8"]
}


variable "alb_name" {
  type        = string
  default     = "cloudzenia-alb"
}


variable "wordpress_target_group_name" {
  description = "Name of the WordPress Target Group"
  type        = string
  default     = "wordpress-target-gp"
}

variable "microservice_target_group_name" {
  description = "Name of the Microservice Target Group"
  type        = string
  default     = "nodjs-microservice-target-gp"
}

variable "wordpress_domain" {
  description = "Domain name for the WordPress service"
  type        = string
  default     = "wordpress.shariff.info"
}

variable "microservice_domain" {
  description = "Domain name for the Microservice"
  type        = string
  default     = "microservice.shariff.info"
}

variable "certificate_domain" {
  description = "Domain name for the SSL certificate"
  type        = string
  default     = "*.shariff.info"
}

variable "wordpress_priority" {
  description = "Priority for the WordPress ALB listener rule"
  type        = number
  default     = 10
}

variable "microservice_priority" {
  description = "Priority for the Microservice ALB listener rule"
  type        = number
  default     = 20
}

variable "wordpress_health_check_path" {
  description = "Health check path for WordPress"
  type        = string
  default     = "/wp-login.php"
}

variable "microservice_health_check_path" {
  description = "Health check path for Microservice"
  type        = string
  default     = "/health"
}

