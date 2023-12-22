resource "aws_subnet" "public" {
  count                   = length(var.subnet_cidr_blocks)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "Public-Subnet-${count.index}-${var.environment}"
  }
}
