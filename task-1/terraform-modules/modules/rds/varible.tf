
variable "rds_instance_name" {}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "enable_parameter_group" {}

variable "allocated_storage" {}

variable "max_allocated_storage" {}

variable "storage_type" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "multi_az" {}

variable "publicly_access" {}

variable "skip_final_snapshot" {}

variable "final_snapshot_identifier" {}

variable "backup_retention_period" {}

variable "backup_window" {}

variable "maintenance_window" {}

variable "enable_enhanced_monitoring" {}

variable "performance_insights_enabled" {}

variable "storage_encryption" {}

variable "apply_immediately" {}

variable "enable_cloudwatch_logs_exports" {}

variable "rds_instance_tags" {}

variable "rds_sg_id" {}

variable "secret_id" {}
