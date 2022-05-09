resource "aws_instance" "jumphost" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t3.micro"
  key_name          = aws_key_pair.bootcamp-key.key_name

  root_block_device {
    volume_size = 50
  }

  subnet_id = aws_subnet.bootcamp-public-subnet.id
  vpc_security_group_ids = [aws_security_group.all-bootcamp.id, aws_security_group.external-access.id]
  associate_public_ip_address = true

  tags = {
    Name        = "Bootcamp Jumphost"
    description = "Jumphost for Bootcamp - Managed by Terraform"
    sshUser     = "ubuntu"
    region      = var.region
  }
}
