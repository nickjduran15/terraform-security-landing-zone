#!/bin/bash
# User data script for application servers

# Update system
yum update -y

# Install required packages
yum install -y httpd amazon-cloudwatch-agent

# Configure CloudWatch agent
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "metrics": {
    "namespace": "${project}-${environment}",
    "metrics_collected": {
      "cpu": {
        "measurement": [
          "cpu_usage_idle",
          "cpu_usage_iowait",
          "cpu_usage_user",
          "cpu_usage_system"
        ],
        "metrics_collection_interval": 60,
        "totalcpu": false
      },
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "metrics_collection_interval": 60,
        "resources": [
          "*"
        ]
      },
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
            "file_path": "/var/log/httpd/access_log",
            "log_group_name": "/aws/application/${project}-${environment}",
            "log_stream_name": "{instance_id}/apache/access"
          },
          {
            "file_path": "/var/log/httpd/error_log",
            "log_group_name": "/aws/application/${project}-${environment}",
            "log_stream_name": "{instance_id}/apache/error"
          }
        ]
      }
    }
  }
}
EOF

# Start CloudWatch agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -s \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Create simple web page
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>FinTech Landing Zone</title>
</head>
<body>
    <h1>FinTech Payment Processing Platform</h1>
    <p>Environment: ${environment}</p>
    <p>Instance ID: $(ec2-metadata --instance-id | cut -d " " -f 2)</p>
    <p>Availability Zone: $(ec2-metadata --availability-zone | cut -d " " -f 2)</p>
</body>
</html>
EOF

# Create health check endpoint
cat > /var/www/html/health <<EOF
OK
EOF

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Install AWS CLI and SSM Agent (for troubleshooting)
yum install -y aws-cli amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
