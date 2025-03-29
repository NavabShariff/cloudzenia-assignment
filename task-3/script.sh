#!/bin/bash

USER_ID=$(id -u)

if [[ ${USER_ID} -ne 0 ]] ; then

  echo "you can't install jenkins, user should be a root user"
  echo "help: sudo su"
  exit 1

fi

which unzip

if [ $? == 0 ]; then
  echo "unzip is already available"
else
  apt install unzip -y
fi

wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
unzip AmazonCloudWatchAgent.zip
sudo ./install.sh




# Create CloudWatch Agent configuration file
sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json > /dev/null <<EOT
{
	"metrics": {
		"append_dimensions": {
			"InstanceId": "${aws:InstanceId}"
		},
		"metrics_collected": {
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
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
            "log_stream_name": "$INSTANCE_ID"
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
