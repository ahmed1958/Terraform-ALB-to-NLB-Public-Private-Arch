vpc-data = {
#here is the cidr and the name of the vpc
     "vpc_1" = "10.0.0.0/16"
     }

subnet-data = {
     "public_sub1" = ["10.0.1.0/24","us-east-1a","vpc_1"],
     "public_sub2" = ["10.0.2.0/24","us-east-1b","vpc_1"],
     "privte_sub1" = ["10.0.3.0/24","us-east-1a","vpc_1"],
     "privte_sub2" = ["10.0.4.0/24","us-east-1b","vpc_1"]
     }

igw-data = {
     "my-gateway" = "vpc_1"
    }
my-routes-data = {
"my_public_route_table" =["vpc_1","0.0.0.0/0","my-gateway"],
"my_privte_route_table" =[ "vpc_1","0.0.0.0/0"]
}
terraform-associate-data= {
  "public_sub1" = ["my_public_route_table"],
  "public_sub2" = ["my_public_route_table"],
  "privte_sub1"=["my_privte_route_table"]
  "privte_sub2"=["my_privte_route_table"]
} 
eip_bool = true
sub_Nat = "public_sub1"

my-sec-data= {
     "my-sec-1"=["vpc_1",22,"tcp","0.0.0.0/0",80,"tcp","0.0.0.0/0",0,"-1","0.0.0.0/0"]
}

my-privte-ec2-data= {
  "hamada priv1" = [ "ami-066784287e358dad1", "t2.micro" , "privte_sub1" , false ,"my-sec-1","DAY3",
   <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd 
      systemctl start httpd 
      systemctl enable httpd
      echo "It works from 1" > /var/www/html/index.html
      systemctl restart httpd 
    EOF 
      ,
      "privte"  ],
   "hamada priv2" = [ "ami-066784287e358dad1", "t2.micro" , "privte_sub2" , false ,"my-sec-1","DAY3",
   <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd 
      systemctl start httpd 
      systemctl enable httpd
      echo "It works from 2" > /var/www/html/index.html
      systemctl restart httpd 
    EOF 
      ,
      "privte"  ]   
}

my-public-ec2-data = {
  "hamada public1" = [ "ami-066784287e358dad1", "t2.micro" , "public_sub1" , true,"my-sec-1","DAY3",
   <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y nginx
      systemctl start nginx
      systemctl enable nginx
    EOF 
      ,
      "public"  ]
}
lb_data= {
     "my-internal-load-balancer":[true,"network","nlb-security-group","privte_sub1","privte_sub2",false]}
nlb_sg-data=  {
     "nlb-security-group"= [0,"tcp","0.0.0.0/0",80,-1]
}

target_group = {"internal-target-group" =[80,"TCP","traffic-port"] }
listener-data= {"my-internal-load-balancer"=[80,"TCP", "forward","internal-target-group"] }
private_key_path="/home/ahmed/Downloads/DAY3.pem"
