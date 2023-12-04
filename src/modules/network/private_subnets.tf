resource "aws_subnet" "privates" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index].private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.app_name}-private-${count.index}"
  }
}

resource "aws_route_table" "private_route_tables" {
  count  = length(var.subnets)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngws[count.index].id
  }

  tags = {
    Name = "${var.app_name}-private_route_tables-${count.index}"
  }
}

resource "aws_route_table_association" "private_associations" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}
