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

output "sambahost-private-ip" {
  description = "Show the private IP of the samba host"
  value = aws_instance.sambahost.private_ip
}

output "vpc-id" {
  description = "The IP of the bootcamp VPC"
  value = aws_vpc.vpc.id
}

output "bootcamp-security-group" {
  description = "Id of the security group for internal access"
  value = aws_security_group.all-bootcamp.id
}

output "external-bootcamp-security-group" {
  description = "Id of the security group for external access"
  value = aws_security_group.external-access.id
}

output "public-subnets" {
  description = "Public subnet for all external-facing instances"
  value = [ aws_subnet.bootcamp-public-subnet.*.id ]
}

output "private-subnets" {
  description = "Subnet AZ1 for creating Confluent Cluster"
  value = [ aws_subnet.bootcamp-private-subnet.*.id ]
}

output "hosted-zone-id" {
  description = "Route 53 internal hosted zone"
  value = aws_route53_zone.private.id
}

output "vault-unseal-key-id" {
  description = "Vault unseal key id"
  value = aws_kms_key.vault.key_id
}
