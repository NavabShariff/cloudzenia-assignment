output "rds_endpoint" {
  description = "The DNS endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}
