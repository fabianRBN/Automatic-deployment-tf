resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination_cidr_block
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "rtb-${var.environment}"
  }
}
