# Create a NAT Gateway!
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway.id
  subnet_id = aws_subnet.public-az-a.id

  tags = {
    Name = "an-nat-gateway"
  }

  depends_on = [
    aws_eip.nat-gateway
  ]
}