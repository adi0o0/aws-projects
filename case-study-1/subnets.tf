resource "aws_subnet" "private-az-a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "an private subnet az a"
  }
}

resource "aws_subnet" "private-az-b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "an private subnet az b"
  }
}

resource "aws_subnet" "public-az-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = "eu-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "an public subnet az a"
  }
}

resource "aws_subnet" "public-az-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.20.0/24"
  availability_zone       = "eu-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "an public subnet az b"
  }
}