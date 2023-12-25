# Launch Template para instancias web
resource "aws_launch_template" "web" {
  name_prefix   = "web-lt-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  # Configuración de la red
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = var.security_group_ids
  }


  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-instance-${var.environment}"
    }
  }
}

# Auto Scaling Group para instancias web
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  # Para balanceadores de carga, si están siendo utilizados
  # target_group_arns    = var.target_group_arns

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "0"

  tag {
    key                 = "Name"
    value               = "web-asg-instance-${var.environment}"
    propagate_at_launch = true
  }

  # Más configuraciones pueden incluirse aquí...
}
