  module "vpc" {
    source          = "/home/ahmed/Terraform_modules /VPC_module "
    vpc-data= var.vpc-data
    subnet-data= var.subnet-data
    igw-data= var.igw-data
    my-routes-data= var.my-routes-data
    terraform-associate-data= var.terraform-associate-data
    eip_bool=var.eip_bool
    sub_Nat=var.sub_Nat
  }
module "EC2" {  
  source = "/home/ahmed/Terraform_modules /EC2_module"
  vpc_id = module.vpc.vpc_id
  subnet_map  = module.vpc.subnet_map
  nat_gateway_id = module.vpc.nat_gateway_id 
  my-privte-ec2-data = var.my-privte-ec2-data
  my-public-ec2-data=  var.my-public-ec2-data
  my-sec-data= var.my-sec-data
  private_key_path=var.private_key_path
}

module "load_balancer" {
  source = "/home/ahmed/Terraform_modules /loadbalancer"
  vpc_id = module.vpc.vpc_id
  subnet_map  = module.vpc.subnet_map
  ec2_instance_ids = module.EC2.ec2_instance_ids
  lb_data= var.lb_data
  nlb_sg-data=var.nlb_sg-data
  target_group= var.target_group
  listener-data=var.listener-data

}
