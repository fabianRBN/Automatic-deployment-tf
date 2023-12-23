resource "aws_network_interface" "ni" {
  count = length(var.subnet_ids)

  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]

  tags = {
    Name = "ni-${var.environment}-${count.index}"
  }
}