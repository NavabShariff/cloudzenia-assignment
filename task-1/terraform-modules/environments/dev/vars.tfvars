# global
region = "ap-south-1"

profile = "default"

# vpc-network
vpc_name = "navab"

vpc_cidr = "192.168.0.0/16"

azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

public_subnet_cidr = ["192.168.0.0/20", "192.168.16.0/20"]

public_subnet_names = ["public-subnet-1", "public-subnet-2"]

private_subnet_cidr = ["192.168.48.0/20", "192.168.64.0/20"]

private_subnet_names = ["private-subnet-1", "private-subnet-2"]

enable_nat_gateway = false


# security-groups

alb_sg_name = "navab-alb-sg"

ecs_sg_name = "navab-ecs-sg"

rds_sg_name = "navab-rds-sg"

# rds

rds_instance_name = "navab-wordpress-db-instance"


enable_parameter_group = false

allocated_storage = "20"

max_allocated_storage = "50"

storage_type = "gp3"

engine = "mysql"

engine_version = "8.0"

instance_class = "db.t3.micro"

multi_az = false

publicly_access = false

skip_final_snapshot = true

final_snapshot_identifier = "last-snapshot"

backup_retention_period = "7"

backup_window = "03:00-04:00"

maintenance_window = "Sun:05:00-Sun:06:00"

enable_enhanced_monitoring = false

performance_insights_enabled = false

storage_encryption = false

apply_immediately = true

enable_cloudwatch_logs_exports = false

rds_instance_tags = {
  Name = "navab-wordpress-db-instance"
  client = "navab"
}

secret_id = "wordpress-secrets"
