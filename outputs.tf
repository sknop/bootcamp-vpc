output "private-key-name" {
  description = "The private key name needed to log into the jumphost"
  value = local_file.private_key.filename
}

output "jumphost-ip" {
  description = "The jumphost IP. Remember that the username is 'ubuntu'"
  value = aws_instance.jumphost.public_ip
}

output "sambahost-ip" {
  description = "The sambahost IP. Remember that the username is 'ubuntu'"
  value = aws_instance.sambahost.public_ip
}

output "vpc-id" {
  description = "The IP of the bootcamp VPC"
  value = aws_vpc.vpc.id
}

output "bootcamp-security-group" {
  description = "Id of the security group for internal access"
  value = aws_security_group.all-bootcamp.id
}

output "subnet-for-az1" {
  description = "Single Subnet (1 AZ) for creating Confluent Cluster"
  value = aws_subnet.bootcamp-private-subnet-1.id
}

output "hosted-zone-id" {
  description = "Route 53 internal hosted zone"
  value = aws_route53_zone.private.id
}
