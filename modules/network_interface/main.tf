/* resource "aws_network_interface" "ni" {
  count = length(var.subnet_ids)

  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]

  tags = {
    Name = "ni-${var.environment}-${count.index}"
  }
} */

resource "aws_network_interface" "web_ni" {
  count = length(var.subnet_ids)

  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.web_sg_id]

  tags = {
    Name = "web-ni-${count.index}-${var.environment}"
  }
}

resource "aws_network_interface" "db_ni" {
  count = length(var.subnet_ids)

  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.db_sg_id]

  tags = {
    Name = "db-ni-${count.index}-${var.environment}"
  }
}
