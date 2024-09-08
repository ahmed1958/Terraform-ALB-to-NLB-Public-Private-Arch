output "subnet_map" {
  description = "Map of subnet names to subnet IDs"
  value = { for name, subnet in aws_subnet.my-subnet : name => subnet.id }
}
output "vpc_id" {
  value = aws_vpc.main["vpc_1"].id
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat[0].id
  description = "The ID of the NAT gateway"
}