resource "aws_vpc" "main" {
 for_each = var.vpc-data
 cidr_block = each.value
 
 tags = {
   Name = each.key
 }
}
resource "aws_subnet" "my-subnet" {
  vpc_id = aws_vpc.main[each.value[2]].id
  for_each = var.subnet-data
  cidr_block = each.value[0]
  availability_zone = each.value[1]
  tags = {
    Name = each.key,
  }
}

resource "aws_internet_gateway" "gw" {
  for_each = var.igw-data
  vpc_id = aws_vpc.main[each.value].id

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "my_routes" {
  for_each = var.my-routes-data
  vpc_id = aws_vpc.main[each.value[0]].id

  route {
    cidr_block = each.value[1]
    gateway_id = each.key == "my_public_route_table" ? aws_internet_gateway.gw[each.value[2]].id : null
    nat_gateway_id = each.key == "my_privte_route_table" ?  aws_nat_gateway.nat[0].id : null
  }


  tags = {
    Name = each.key
  }
  depends_on = [ aws_internet_gateway.gw ,aws_nat_gateway.nat ]
}

resource "aws_route_table_association" "terraform-associate" {

  for_each = var.terraform-associate-data
  subnet_id      = aws_subnet.my-subnet[each.key].id
  route_table_id = aws_route_table.my_routes[each.value[0]].id
}
resource "aws_eip" "nat" {
      count = var.eip_bool ? 1 : 0
      domain = "vpc"
  #      lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_nat_gateway" "nat" {
  count = var.eip_bool ? 1 : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.my-subnet[var.sub_Nat].id
#  lifecycle {
#     prevent_destroy = true
#   }
}
