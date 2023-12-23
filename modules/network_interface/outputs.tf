output "web_network_interface_ids" {
  value = aws_network_interface.web_ni.*.id
}

output "db_network_interface_ids" {
  value = aws_network_interface.db_ni.*.id
}
