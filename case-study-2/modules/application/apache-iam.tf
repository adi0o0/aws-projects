resource "aws_iam_instance_profile" "apache-profile" {
  name = var.apache_profile_name
  role = aws_iam_role.apache-role.name
}

resource "aws_iam_role" "apache-role" {
  name               = var.apache_role_name
  description        = "apache-role"
  assume_role_policy = templatefile("${path.module}/templates/server-assume-policy.json", {})
}

resource "aws_iam_policy" "s3-access-iam-apache" {
  policy = templatefile("${path.module}/templates/s3-access-inline-policy-apache.json", {
    bucket_name = var.bucket_name
  })
}

resource "aws_iam_role_policy_attachment" "s3-access-policy" {
  role       = aws_iam_role.apache-role.name
  policy_arn = aws_iam_policy.s3-access-iam-apache.arn
}

resource "aws_iam_role_policy_attachment" "apache-policy" {
  role       = aws_iam_role.apache-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}