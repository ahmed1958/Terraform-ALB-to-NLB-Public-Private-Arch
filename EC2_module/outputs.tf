output "ec2_instance_ids" {
  value = {
    for instance in aws_instance.privte_EC2 : instance.tags.Name => instance.id
  }
}