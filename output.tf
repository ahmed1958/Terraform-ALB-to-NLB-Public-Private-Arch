# output "private_instance_ips" {
#   value = module.EC2.private_instance_ips
# }
output "load_balancer_dns" {
  value = module.load_balancer.load_balancer_dns
  description = "The DNS name of the load balancer"
}