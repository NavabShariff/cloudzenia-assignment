#!/bin/bash



# Update system packages
sudo apt update -y

# Install NGINX and CloudWatch Agent
sudo apt install -y amazon-cloudwatch-agent



# Create CloudWatch Agent configuration file
sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json > /dev/null <<EOT
{
  "metrics": {
    "metrics_collected": {
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 60
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/nginx/access.log",
            "log_group_name": "/nginx/access-logs",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOT

# Start CloudWatch Agent
sudo amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Enable CloudWatch Agent to start on boot
sudo systemctl enable amazon-cloudwatch-agent

echo "Setup complete: NGINX and CloudWatch Agent configured successfully!"
