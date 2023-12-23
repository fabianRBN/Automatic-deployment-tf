output "network_interface_ids" {
  value = aws_network_interface.ni.*.id
}
