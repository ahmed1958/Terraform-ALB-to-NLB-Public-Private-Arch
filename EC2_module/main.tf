resource "aws_security_group" "my_sec" {
for_each =var.my-sec-data
  
  
  vpc_id = var.vpc_id

  ingress {
    from_port   = each.value[1]
    to_port     = each.value[1]
    protocol    = each.value[2]
    cidr_blocks = [each.value[3]]
  }

  ingress {
    from_port   = each.value[4]
    to_port     = each.value[4]
    protocol    = each.value[5]
    cidr_blocks = [each.value[6]]
  }

  egress {
    from_port   = each.value[7]
    to_port     = each.value[7]
    protocol    = each.value[8]
    cidr_blocks = [each.value[9]]
  }

  tags = {
    Name = each.key
  }
}


resource "aws_instance" "privte_EC2" {
  for_each = var.my-privte-ec2-data
  ami                    = each.value[0]  
  instance_type          = each.value[1]                
  subnet_id              = var.subnet_map[each.value[2]]         
  associate_public_ip_address = each.value[3]

  # Attach the security group
vpc_security_group_ids = [aws_security_group.my_sec[each.value[4]].id]


  key_name = each.value[5]  # Replace with your key pair name

  user_data = each.value[6]

  

  tags = {
    Name = each.key
    type = each.value[7]
  }
 depends_on = [var.nat_gateway_id]
  
}
resource "aws_instance" "Public_EC2" {
  for_each = var.my-public-ec2-data

  ami                    = each.value[0]  
  instance_type          = each.value[1]                
  subnet_id              = var.subnet_map[each.value[2]]        
  associate_public_ip_address = each.value[3]

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.my_sec[each.value[4]].id]

  key_name = each.value[5]  # Replace with your key pair name

  user_data = each.value[6]

  provisioner "file" {
    source      = "/home/ahmed/Terraform_modules /nginx.conf"  # Path to your local config file
    destination = "/tmp/nginx.conf"      # Destination on the public EC2 instance

    connection {
      type        = "ssh"
      user        = "ec2-user"  # Replace with the correct user (e.g., ubuntu, ec2-user)
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/nginx",
      "sudo cp /tmp/nginx.conf /etc/nginx/nginx.conf",  # Copy the file to the correct location
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = each.key
  }
}