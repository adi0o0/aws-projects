resource "aws_security_group" "server" {
  name   = "an-server-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "server-in" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.server.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "server-out" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.server.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}