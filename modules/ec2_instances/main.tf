resource "aws_instance" "example" {
  count                       = length(var.subnet_ids)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index]
  associate_public_ip_address = true  # Asignar IP pública
  vpc_security_group_ids      = [var.security_group_id]  # Usar el ID del Security Group

  tags = {
    Name = "Instance-${count.index}-${var.environment}"
  }
}