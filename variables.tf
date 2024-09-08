variable "vpc-data" { 
  description = "main cidr and the name tag for the vpc" 
  type = map(string)
}

variable "subnet-data" { 
  description = "defining the subnets" 
  type = map(list(string))
}

variable "igw-data" { 
  description = "defining the internet_gateway" 
  type = map(string)
}

variable "my-routes-data" { 
  description = "defining the route_tables_data" 
  type = map(list(string))
}

variable "terraform-associate-data" {
  description = "assosiate subnet with route table" 
  type = map(list(string))
}
variable "eip_bool" {
  description = "eip" 
  type = bool
}
variable "sub_Nat" {
  description = "nat_way" 
  type = string
}  
variable "my-privte-ec2-data" {
  description = "privte ec2 data" 
  type = map(list(string))
}
variable "my-sec-data" {
  description = "security groups" 
  type = map(list(string))
}
variable "my-public-ec2-data" {
  description = "public ec2 data" 
  type = map(list(string))
}
variable "lb_data" {
description = "lb data"
type = map(list(string))
}
variable "nlb_sg-data" {
    description = "lb-sg"
    type = map(list(string))
}
variable "target_group" {
    description = "target_group"
    type = map(list(string))
}
variable "listener-data" {
    description = "listner data"
    type = map(list(string))
}
variable "private_key_path" {
   type        = string
}