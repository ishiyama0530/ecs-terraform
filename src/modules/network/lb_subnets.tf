resource "aws_subnet" "lb_subnets" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index].lb_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.app_name}-lb-${count.index}"
  }
}
