resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "an public route table"
  }
}

resource "aws_route_table_association" "route-associate-public-a" {
  subnet_id      = aws_subnet.public-az-a.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "route-associate-public-b" {
  subnet_id      = aws_subnet.public-az-b.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "an private route table"
  }
}

resource "aws_route_table_association" "route-associate-private-a" {
  subnet_id      = aws_subnet.private-az-a.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "route-associate-private-b" {
  subnet_id      = aws_subnet.private-az-b.id
  route_table_id = aws_route_table.private-route.id
}
