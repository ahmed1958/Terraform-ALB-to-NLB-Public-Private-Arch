# resource "aws_lb" "internal_nlb" {
#   for_each = var.lb_data
#   name               = each.key
#   internal           = each.value[0]
#   load_balancer_type = each.value[1]
#   security_groups    = [aws_security_group.nlb_sg[each.value[2]].id]
#   subnets            = [var.subnet_map[each.value[3]], var.subnet_map[each.value[4]]]

#   enable_deletion_protection = each.value[5]

#   tags = {
#     Name = each.key
#   }
# }

# resource "aws_security_group" "nlb_sg" {
#   for_each = var.nlb_sg-data
#   name        = each.key
#   description = each.value[0]
#   vpc_id      = var.vpc_id

#   egress {
#     from_port   = each.value[1]
#     to_port     = each.value[1]
#     protocol    =  each.value[2]
#     cidr_blocks = [ each.value[3]]
#   }

#   ingress {
#     from_port   = each.value[4]
#     to_port     = each.value[4]
#     protocol    = each.value[2]
#     cidr_blocks = [each.value[3]]
#   }
# }

# resource "aws_lb_target_group" "tg" {
#  for_each = var.target_group
#   name     = each.key
#   port     = each.value[0]
#   protocol = each.value[1]
#   vpc_id   = var.vpc_id

#   health_check {
#     protocol = each.value[1]
#     port     = each.value[2]
#   }
# }
# resource "aws_lb_listener" "tcp" {
#   for_each = var.listener-data
#   load_balancer_arn = aws_lb.internal_nlb[each.key].arn
#   port              = each.value[0]
#   protocol          = each.value[1]

#   default_action {
#     type             = each.value[2]
#     target_group_arn = aws_lb_target_group.tg[each.value[3]].arn
#   }
# }
# resource "aws_lb_target_group_attachment" "attach_ec2s" {
#   for_each = var.ec2_instance_ids
#   target_group_arn   = aws_lb_target_group.tg["internal-target-group"].arn
#   target_id          = each.value
#   port               = 80
# }
resource "aws_security_group" "nlb_security_group" {
  for_each = var.nlb_sg-data
  vpc_id = var.vpc_id
  name   = each.key

  ingress {
    from_port   = each.value[3]
    to_port     = each.value[3]
    protocol    = each.value[1]
    cidr_blocks = [each.value[2]]
  }

  egress {
    from_port   = each.value[0]
    to_port     = each.value[0]
    protocol    = each.value[4]
    cidr_blocks = [each.value[2]]
  }
}

resource "aws_lb" "internal_lb" {
  for_each = var.lb_data
  name               = each.key
  internal           = each.value[0]
  load_balancer_type = each.value[1]
  security_groups    = [aws_security_group.nlb_security_group[each.value[2]].id]
  subnets            = [var.subnet_map[each.value[3]], var.subnet_map[each.value[4]]]
}

resource "aws_lb_target_group" "internal_target_group" {
  for_each = var.target_group
  name     = each.key
  port     = each.value[0]
  protocol = each.value[1]
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "lb_listener" {
  for_each = var.listener-data
  load_balancer_arn = aws_lb.internal_lb[each.key].arn
  port              = each.value[0]
  protocol          = each.value[1]
  
  default_action {
    type             = each.value[2]
    target_group_arn = aws_lb_target_group.internal_target_group[each.value[3]].arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each = var.ec2_instance_ids

  target_group_arn = aws_lb_target_group.internal_target_group["internal-target-group"].arn
  target_id        = each.value
  port             = 80
}