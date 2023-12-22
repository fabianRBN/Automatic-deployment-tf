resource "aws_security_group" "this" {
  name        = "secg-${var.environment}"
  description = "Security group for environment ${var.environment}"
  vpc_id      = var.vpc_id

  # Ejemplo de regla de ingreso: permite todo el tráfico entrante en el puerto 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ejemplo de regla de salida: permite todo el tráfico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secg-${var.environment}"
  }
}
