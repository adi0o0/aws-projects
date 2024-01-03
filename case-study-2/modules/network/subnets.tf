resource "aws_subnet" "public" {
  for_each          = var.public_subnet_numbers
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr
}

resource "aws_subnet" "private" {
  for_each          = var.private_subnet_numbers
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr
}