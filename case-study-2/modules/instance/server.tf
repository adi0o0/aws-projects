resource "aws_instance" "server" {
  ami                         = data.aws_ami.linux.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet-ids
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true
  key_name                    = aws_key_pair.server.key_name
  iam_instance_profile        = aws_iam_instance_profile.server-profile.name
  tags = {
    Name = "an-server"
  }
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "server" {
  key_name   = "bast-key"
  public_key = tls_private_key.server.public_key_openssh
}

resource "local_file" "server" {
  content         = tls_private_key.server.private_key_pem
  filename        = "bast-key.pem"
  file_permission = "400"
}