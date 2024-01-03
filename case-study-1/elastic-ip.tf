resource "aws_eip" "nat-gateway" {
  vpc = true

  tags = {
    Name = "an-elastic-ip"
  }
}