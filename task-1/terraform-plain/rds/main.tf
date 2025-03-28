provider "aws" {
  region = var.region
  profile = var.profile
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.rds_instance_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}


resource "aws_db_parameter_group" "rds_parameter_group" {
  count = var.enable_parameter_group ? 1 : 0

  name   = "${var.rds_instance_name}-parameter-group"
  family = "mysql8.0"

  parameter {
    name  = "max_connections"
    value = "500"
  }

  tags = {
    Name = "${var.rds_instance_name}-parameter-group"
  }
}


data "aws_secretsmanager_secret_version" "db_creds" {
  secret_id = var.secret_id
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.db_creds.secret_string
  )
}


# Create the RDS instance
resource "aws_db_instance" "rds_instance" {
  identifier             = var.rds_instance_name
  allocated_storage      = var.allocated_storage      
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = var.storage_type                        
  engine                 = var.engine                         
  engine_version         = var.engine_version                          
  instance_class         = var.instance_class                 
  db_name                = local.db_creds.dbname                     
  username               = local.db_creds.username                  
  password               = local.db_creds.password

  parameter_group_name   = var.enable_parameter_group ? aws_db_parameter_group.rds_parameter_group[0].name : null
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.rds_sg_id
 
  skip_final_snapshot       =  var.skip_final_snapshot
  final_snapshot_identifier  = var.skip_final_snapshot ? null : "${var.rds_instance_name}-${var.final_snapshot_identifier}"
 

  multi_az               = var.multi_az        
  publicly_accessible    = var.publicly_access

  backup_retention_period = var.backup_retention_period                      
  backup_window           = var.backup_window              

  maintenance_window      = var.maintenance_window

  # Enable monitoring and enhanced logging
  monitoring_interval     = var.enable_enhanced_monitoring ? 300 : 0
  monitoring_role_arn     = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring_role[0].arn : null

  # Enable Performance Insights
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? 7 : 0     
  performance_insights_kms_key_id = var.performance_insights_enabled ? aws_kms_key.rds_insights_kms[0].arn : null

  # Enable Encryption at rest
  storage_encrypted   = var.storage_encryption
  kms_key_id          = var.storage_encryption ? aws_kms_key.rds_encryption[0].arn : null

  apply_immediately = var.apply_immediately  # Optional, apply changes immediately (not recommended for production)

  tags = merge(
     var.rds_instance_tags
  )

  enabled_cloudwatch_logs_exports = var.enable_cloudwatch_logs_exports ? [
    "audit",       # Audit log
    "error",       # Error log
    "general",     # General log
    "slowquery",   # Slow query log
  ] : []
 
  depends_on = [
    aws_iam_role.rds_monitoring_role, 
    aws_iam_role_policy_attachment.rds_monitoring
  ]

  # depends_on = var.enable_enhanced_monitoring ? [aws_iam_role_policy_attachment.rds_monitoring] : []
}

# # IAM Role for Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring_role" {

  count = var.enable_enhanced_monitoring ? 1 : 0
  name = "${var.rds_instance_name}-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the necessary policy to the role
resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  count = var.enable_enhanced_monitoring ? 1 : 0
  role       = aws_iam_role.rds_monitoring_role[0].name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# KMS Key for RDS Encryption
resource "aws_kms_key" "rds_encryption" {
  count = var.storage_encryption ? 1 : 0
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 10

  tags = {
    Name = "${var.rds_instance_name}-encryption"
  }
}

# KMS Key for Performance Insights
resource "aws_kms_key" "rds_insights_kms" {
  count = var.performance_insights_enabled ? 1 : 0
  description             = "KMS key for RDS Performance Insights"
  deletion_window_in_days = 10

  tags = {
    Name = "${var.rds_instance_name}-insights-encryption"
  }
}