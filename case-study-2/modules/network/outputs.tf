output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.public[keys(var.public_subnet_numbers)[0]].id]
}

output "public_subnets" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnets" {
  value = [for subnet in aws_subnet.private : subnet.id]
}