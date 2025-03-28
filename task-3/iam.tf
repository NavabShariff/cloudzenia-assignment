resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "CloudWatchAgentRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "cloudwatch_agent_policy" {
  name        = "CloudWatchAgentPolicy"
  description = "Policy to allow EC2 to send logs and metrics to CloudWatch"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.cloudwatch_agent_role.name
  policy_arn = aws_iam_policy.cloudwatch_agent_policy.arn
}

resource "aws_iam_instance_profile" "cloudwatch_agent_profile" {
  name = "CloudWatchAgentProfile"
  role = aws_iam_role.cloudwatch_agent_role.name
}


# outputs

output "iam_role_name" {
  description = "Name of the IAM Role assigned to EC2 for CloudWatch Agent"
  value       = aws_iam_role.cloudwatch_agent_role.name
}


output "iam_instance_profile" {
  description = "IAM Instance Profile name for CloudWatch Agent"
  value       = aws_iam_instance_profile.cloudwatch_agent_profile.name
}
