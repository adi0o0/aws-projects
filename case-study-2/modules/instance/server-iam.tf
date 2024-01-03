resource "aws_iam_instance_profile" "server-profile" {
  name = var.server
  role = aws_iam_role.server-role.name
}

resource "aws_iam_role" "server-role" {
  name               = var.role_name
  assume_role_policy = templatefile("${path.module}/templates/server-assume-policy.json", {})
}

resource "aws_iam_role_policy_attachment" "server-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.server-role.name
}