resource "aws_kms_key" "vault" {
  description   = "Vault unseal key"
  deletion_window_in_days = 30

  tags = {
    Name = var.bootcamp-key-name
  }
}

resource "aws_kms_alias" "vault" {
  name    = var.vault-unseal-key-alias
  target_key_id = aws_kms_key.vault.key_id
}

resource "aws_instance" "sambahost" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.samba-instance-type
  key_name          = aws_key_pair.bootcamp-key.key_name

  root_block_device {
    volume_size = 50
  }

  subnet_id = aws_subnet.bootcamp-public-subnet[0].id
  vpc_security_group_ids = [
    aws_security_group.all-bootcamp.id,
    aws_security_group.external-access.id,
    aws_security_group.keycloak-access.id
  ]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.vault-kms-unseal.id

  tags = {
    Name        = "Bootcamp Sambahost"
    description = "Sambahost for Bootcamp - Managed by Terraform"
    Owner_Name  = var.owner_name
    Owner_Email = var.owner_email
    sshUser     = "ubuntu"
    region      = var.region
  }
}

resource "aws_route53_record" "sambahost" {
  zone_id = aws_route53_zone.private.id
  name = "samba"
  type = "A"
  ttl = "300"
  records = [aws_instance.sambahost.private_ip]
}
