resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "nat-gateway" {
  domain = "vpc"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway.id
  subnet_id     = aws_subnet.public[element(keys(aws_subnet.public), 0)].id
  depends_on = [
    aws_eip.nat-gateway
  ]
}