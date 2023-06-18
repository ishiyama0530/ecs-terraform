output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "lb_subnet_ids" {
  value = aws_subnet.lb_subnets[*].id
}
