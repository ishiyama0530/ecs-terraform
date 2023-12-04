resource "aws_nat_gateway" "ngws" {
  count         = length(var.subnets)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id

  tags = {
    Name = "${var.app_name}-ngw-${count.index}"
  }
}

resource "aws_eip" "nat_eip" {
  count  = length(var.subnets)
  domain = "vpc"

  tags = {
    Name = "${var.app_name}-nat_eip-${count.index}"
  }
}
