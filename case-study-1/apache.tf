resource "aws_launch_template" "web-server-template" {
  name                   = "web-server"
  image_id               = "ami-0c96319db4545e18f"
  instance_type          = "t3.micro"
  user_data              = filebase64("${path.module}/templates/webserver.tpl")
  vpc_security_group_ids = [aws_security_group.web-server.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.apache-profile.name
  }

  tags = {
    Name = "an-apache-template"
  }
}

resource "aws_autoscaling_group" "web-servers" {
  vpc_zone_identifier = [aws_subnet.private-az-a.id, aws_subnet.private-az-b.id]
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.web-server-template.id
    version = aws_launch_template.web-server-template.latest_version
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "an-webserver"
  }

  depends_on = [
    aws_nat_gateway.nat-gateway
  ]
}