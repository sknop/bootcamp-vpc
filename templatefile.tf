variable "templatefile" {
  default = "inventory.tftpl"
}

variable "inventory_file" {
  default = "inventory"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/${var.templatefile}", {
    samba_host = aws_instance.sambahost.public_dns,
    samba_ip_address = aws_instance.sambahost.public_ip,
    jump_host = aws_instance.jumphost.public_dns,
    private_key = abspath("${path.module}/${local_file.private_key.filename}")
    domain = var.root-zone
    region = var.region
    kms_key = aws_kms_key.vault.key_id
    keycloak_admin_user = var.keycloak_admin_user
    keycloak_admin_secret = var.keycloak_admin_secret
  })
  filename = var.inventory_file
}
