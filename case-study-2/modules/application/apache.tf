resource "aws_launch_template" "web-server-template" {
  name          = var.launch_template
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data = base64encode(templatefile("${path.module}/templates/webserver.tpl", {
    bucket_name = var.bucket_name
  }))
  vpc_security_group_ids = [aws_security_group.web-server.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.apache-profile.name
  }
  tags = {
    Name = "an-apache-template"
  }
}

resource "aws_autoscaling_group" "web-servers" {
  vpc_zone_identifier = var.private_subnets
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
}