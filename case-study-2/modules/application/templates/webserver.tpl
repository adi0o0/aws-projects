#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
aws s3 cp s3://${bucket_name}/index.html /var/www/html/