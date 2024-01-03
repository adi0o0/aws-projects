resource "aws_instance" "bastion" {
  ami                         = "ami-0c96319db4545e18f"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = aws_subnet.public-az-a.id
  associate_public_ip_address = true
  key_name                    = "bast-key"
  iam_instance_profile        = aws_iam_instance_profile.bastion-profile.name

  tags = {
    Name = "an-bastion"
  }
}

resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "bast-key"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "local_file" "bastion" {
  content         = tls_private_key.bastion.private_key_pem
  filename        = "bast-key.pem"
  file_permission = "400"
}
