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
