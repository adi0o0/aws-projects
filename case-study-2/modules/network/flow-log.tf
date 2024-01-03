resource "aws_flow_log" "cloud-watch" {
  iam_role_arn    = aws_iam_role.iam-flow-logs.arn
  log_destination = aws_cloudwatch_log_group.vpc-logs-group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "vpc-logs-group" {
  name              = "an-flow-logs-group"
  retention_in_days = 14
}

resource "aws_iam_role" "iam-flow-logs" {
  name               = "an-flogs"
  assume_role_policy = templatefile("${path.module}/templates/vpc-logs-policy-assume.json", {})
}

resource "aws_iam_role_policy" "iam-role-policy" {
  name   = "an-vpc-flowlogs"
  role   = aws_iam_role.iam-flow-logs.id
  policy = templatefile("${path.module}/templates/vpc-flow-log-policy.json", {})
}