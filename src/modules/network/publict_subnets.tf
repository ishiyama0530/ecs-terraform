resource "aws_subnet" "publics" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index].public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.app_name}-publics-${count.index}"
  }
}

resource "aws_route_table" "public_route_tables" {
  count  = length(var.subnets)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app_name}-public_route_tables-${count.index}"
  }
}

resource "aws_route_table_association" "public_associations" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.public_route_tables[count.index].id
}
