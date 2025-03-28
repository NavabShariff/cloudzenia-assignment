variable region {
  type        = string
  default     = "ap-south-1"
  description = "description"
}

variable profile {
  type        = string
  default     = "default"
  description = "description"
}


variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default = "vpc-0dbb3ff386dd563ff"
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb-sg"
}

variable "ecs_sg_name" {
  description = "Name of the ECS security group"
  type        = string
  default     = "ecs-sg"
}

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
  default     = "rds-sg"
}
