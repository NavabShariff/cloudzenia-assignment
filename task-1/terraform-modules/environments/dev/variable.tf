# vpc-network

variable "region" {}

variable "profile" {}

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "azs" {}

variable "public_subnet_cidr" {}

variable "public_subnet_names" {}

variable "private_subnet_cidr" {}

variable "private_subnet_names" {}

variable "enable_nat_gateway" {}


# security-groups

variable "alb_sg_name" {}

variable "ecs_sg_name" {}

variable "rds_sg_name" {}

# rds

variable "rds_instance_name" {}

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

variable "secret_id" {}
