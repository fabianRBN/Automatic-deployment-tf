/* resource "aws_instance" "example" {
  count                       = length(var.subnet_ids)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  network_interface {
    network_interface_id = var.network_interface_ids[count.index]
    device_index         = 0
  }

  tags = {
    Name = "Instance-${var.environment}-${count.index}"
  }
} */

resource "aws_instance" "web" {
  count = length(var.web_network_interface_ids)

  ami           = var.ami_web
  instance_type = var.instance_type
  network_interface {
    network_interface_id = var.web_network_interface_ids[count.index]
    device_index         = 0
  }
  tags = {
    Name = "Web-${count.index}-${var.environment}"
  }
}

resource "aws_instance" "db" {
  count = length(var.db_network_interface_ids)

  ami           = var.ami_db
  instance_type = var.instance_type
  network_interface {
    network_interface_id = var.db_network_interface_ids[count.index]
    device_index         = 0
  }
  tags = {
    Name = "DB-${count.index}-${var.environment}"
  }
}
