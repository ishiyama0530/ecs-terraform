resource "aws_subnet" "nat_subnets" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index].nat_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.app_name}-nat_subnets-${count.index}"
  }
}

resource "aws_route_table" "nat_subnets_route_table" {
  count  = length(var.subnets)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.app_name}-nat_subnets_route_table-${count.index}"
  }
}

resource "aws_route_table_association" "nat_subnets_association" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.nat_subnets[count.index].id
  route_table_id = aws_route_table.nat_subnets_route_table[count.index].id
}
