variable "my-sec-data" {
  description = "security groups" 
  type = map(list(string))
}

variable "my-privte-ec2-data" {
  description = "privte ec2 data" 
  type = map(list(string))
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "subnet_map" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)  # Key is the name, value is the subnet ID
}
variable "my-public-ec2-data" {
  description = "public ec2 data" 
  type = map(list(string))
}
variable "nat_gateway_id" {
  description = "The ID of the NAT gateway"
  type        = string
}
variable "private_key_path" {
   type        = string
}