resource "aws_instance" "example" {
  count = length(var.network_interface_ids)

  ami                         = var.ami_id
  instance_type               = var.instance_type
  network_interface {
    network_interface_id = var.network_interface_ids[count.index]
    device_index         = 0
  }

  tags = {
    Name = "Instance-${var.environment}-${count.index}"
  }
}
