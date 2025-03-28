resource "aws_cloudwatch_log_group" "nginx_logs" {
  name = "/nginx/access-logs"
  retention_in_days = 7
}
