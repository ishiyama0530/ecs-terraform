resource "aws_subnet" "private_subnets" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index].private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.app_name}-private-${count.index}"
  }
}

resource "aws_route_table" "private_subnets_route_table" {
  count  = length(var.subnets)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
  }

  tags = {
    Name = "${var.app_name}-private_subnets_route_table-${count.index}"
  }
}

resource "aws_route_table_association" "private_subnets_association" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_subnets_route_table[count.index].id
}
