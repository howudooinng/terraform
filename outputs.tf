# #output count file

# output "ec2_public_ip" {
#   description = "Public IP of the EC2 instance"
#   value       = aws_instance.my-instance[*].public_ip
# }

# output "ec2_private_ip" {
#   description = "Private IP of the EC2 instance"
#   value       = aws_instance.my-instance[*].private_ip
# }

# output "ec2_public_dns" {
#   description = "Public DNS of the EC2 instance"
#   value       = aws_instance.my-instance[*].public_dns
# }
# output "ec2_instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.my-instance[*].id
# }

#output for_each
output "ec2_public_ip" {
  value = [
    for instance in aws_instance.my-instance : instance.public_ip

  ]
} 

output "ec2_public_dns" {
  value = [
    for instance in aws_instance.my-instance : instance.public_dns

  ]
} 

output "ec2_private_ip" {
  value = [
    for instance in aws_instance.my-instance : instance.private_ip

  ]
} 

output "ec2_instance_id" {
  value = [
    for instance in aws_instance.my-instance : instance.id

  ]
} 

output "ec2_instance_type" {
  value = [
    for instance in aws_instance.my-instance : instance.instance_type

  ]
}

output "ec2_ami" {
  value = [
    for instance in aws_instance.my-instance : instance.ami

  ]
}

output "ec2_key_name" {
  value = [
    for instance in aws_instance.my-instance : instance.key_name

  ]
}

output "ec2_security_groups" {
  value = [
    for instance in aws_instance.my-instance : instance.security_groups

  ]
}

output "ec2_root_block_device" {
  value = [
    for instance in aws_instance.my-instance : instance.root_block_device

  ]
}

output "ec2_tags" {
  value = [
    for instance in aws_instance.my-instance : instance.tags

  ]
}

output "ec2_availability_zone" {
  value = [
    for instance in aws_instance.my-instance : instance.availability_zone

  ]
}

output "ec2_vpc_security_group_ids" {
  value = [
    for instance in aws_instance.my-instance : instance.vpc_security_group_ids

  ]
}

output "ec2_subnet_id" {
  value = [
    for instance in aws_instance.my-instance : instance.subnet_id

  ]
}
