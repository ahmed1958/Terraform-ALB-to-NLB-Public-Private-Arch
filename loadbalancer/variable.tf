
variable "lb_data" {
description = "lb data"
type = map(list(string))
}
variable "nlb_sg-data" {
     description = "lb-sg"
     type = map(list(string))
 }
variable "subnet_map" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)  # Key is the name, value is the subnet ID
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "target_group" {
    description = "target_group"
    type = map(list(string))
}
variable "listener-data" {
    description = "listner data"
    type = map(list(string))
}
variable "ec2_instance_ids" {
   description = "Map of ec2 ids to subnet IDs"
  type  = map(string)  # Key is the name, value is the subnet ID
}
