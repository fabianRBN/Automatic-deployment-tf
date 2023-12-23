output "route_table_association_ids" {
  value = aws_route_table_association.rta.*.id
}