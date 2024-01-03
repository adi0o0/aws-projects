resource "aws_flow_log" "cloud-watch" {
  iam_role_arn    = aws_iam_role.iam-flow-logs.arn
  log_destination = aws_cloudwatch_log_group.vpc-logs-group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "vpc-logs-group" {
  name              = "an-flow-logs-group"
  retention_in_days = 14
  skip_destroy      = false
}

data "aws_iam_policy_document" "vps-logs-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-flow-logs" {
  name               = "an-flogs"
  assume_role_policy = data.aws_iam_policy_document.vps-logs-policy.json
}

data "aws_iam_policy_document" "iam-policy-doc" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "iam-role-policy" {
  name   = "an-vpc-flowlogs"
  role   = aws_iam_role.iam-flow-logs.id
  policy = data.aws_iam_policy_document.iam-policy-doc.json
}