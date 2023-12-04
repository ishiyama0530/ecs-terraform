#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "this" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = "${var.app_name}-vpc"
  }
}
