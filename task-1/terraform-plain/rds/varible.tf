variable region {
  type        = string
  default     = "ap-south-1"
}

variable profile {
  type        = string
  default     = "default"
}

variable rds_instance_name {
  type        = string
  default     = "wordpress-db-instance"
}

variable vpc_id {
  type        = string
  default     = "vpc-0dbb3ff386dd563ff"
}

variable subnet_ids {
  type        = list
  default     = [  "subnet-0d0dff24fea104067", "subnet-03db8770304b5a2de"]
}

variable enable_parameter_group {
  type        = bool
  default     = false
}

variable allocated_storage {
  type        = string
  default     = "20"
}

variable max_allocated_storage {
  type        = string
  default     = "50"
}

variable storage_type {
  type        = string
  default     = "gp3"
}

variable engine {
  type        = string
  default     = "mysql"
}

variable engine_version {
  type        = string
  default     = "8.0"
}

variable instance_class {
  type        = string
  default     = "db.t3.micro"
}

variable multi_az {
  type        = bool
  default     = false
}

variable publicly_access {
  type        = bool
  default     = false
}

variable skip_final_snapshot {
  type        = bool
  default     = true
}

variable final_snapshot_identifier {
  type        = string
  default     = "last-snapshot"
}

variable backup_retention_period {
  type        = string
  default     = "7"
}

variable backup_window {
  type        = string
  default     = "03:00-04:00"
}

variable maintenance_window {
  type        = string
  default     = "Sun:05:00-Sun:06:00"
}

variable enable_enhanced_monitoring {
  type        = bool
  default     = false
}

variable performance_insights_enabled {
  type        = bool
  default     = false
}

variable storage_encryption {
  type        = bool
  default     = false
}

variable apply_immediately {
  type        = bool
  default     = true
}

variable "enable_cloudwatch_logs_exports" {
  type    = bool
  default = false
}

variable rds_instance_tags {
  type        = map(any)
  default     = {
    "Name" =  "wordpress-db-instance"
    "client" = "cloudzenia"
  }
}

variable rds_sg_id {
  type        = list(string)
  default     = ["sg-06aac76dac2acbf9b"]
}

variable secret_id {
  type        = string
  default     = "wordpress-secrets"
}