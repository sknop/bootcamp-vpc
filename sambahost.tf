resource "aws_instance" "sambahost" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.large"
  key_name          = aws_key_pair.bootcamp-key.key_name

  root_block_device {
    volume_size = 50
  }

  subnet_id = aws_subnet.bootcamp-public-subnet.id
  vpc_security_group_ids = [aws_security_group.all-bootcamp.id, aws_security_group.external-access.id]
  associate_public_ip_address = true

  tags = {
    Name        = "Bootcamp Sambahost"
    description = "Sambahost for Bootcamp - Managed by Terraform"
    Owner_Name  = var.owner_name
    Owner_Email = var.owner_email
    sshUser     = "ubuntu"
    region      = var.region
  }
}