resource "aws_lb" "lb" {
  name               = "an-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-security-group.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb-web" {
  name     = "an-lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "web-server-attachment" {
  autoscaling_group_name = aws_autoscaling_group.web-servers.id
  lb_target_group_arn    = aws_lb_target_group.alb-web.arn
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-web.id
    type             = "forward"
  }
}

resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-group"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP From Internet"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}