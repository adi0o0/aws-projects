resource "aws_iam_instance_profile" "bastion-profile" {
  name = "an-bastion-profile"
  role = aws_iam_role.bastion-role.name
}

resource "aws_iam_role" "bastion-role" {
  name               = "an-bastion-iam-role"
  description        = "bastion"
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
      }
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "bastion-policy" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "apache-profile" {
  name = "an-apache-profile"
  role = aws_iam_role.apache-role.name
}

resource "aws_iam_role" "apache-role" {
  name               = "an-apache-iam-role"
  description        = "apache-role"
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
      }
    }
  EOF
  inline_policy {
    name = "S3-access"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:GetObject"]
          Effect   = "Allow"
          Resource = "arn:aws:s3:::an-web-server/*"
        }
      ]
    })
  }
}

resource "aws_iam_role_policy_attachment" "apache-policy" {
  role       = aws_iam_role.apache-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}