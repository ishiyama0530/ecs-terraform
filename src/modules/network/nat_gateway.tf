resource "aws_nat_gateway" "nat_gateways" {
  count         = length(var.subnets)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.nat_subnets[count.index].id

  tags = {
    Name = "${var.app_name}-nat_gateways-${count.index}"
  }
}

resource "aws_eip" "nat_eip" {
  count  = length(var.subnets)
  domain = "vpc"

  tags = {
    Name = "${var.app_name}-nat_eip-${count.index}"
  }
}
