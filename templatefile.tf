variable "templatefile" {
  default = "inventory.tftpl"
}

variable "inventory_file" {
  default = "inventory"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/${var.templatefile}", {
    samba_host = aws_instance.sambahost.public_dns,
    jump_host = aws_instance.jumphost.public_dns,
    private_key = abspath("${path.module}/${local_file.private_key.filename}")
    domain = var.root-zone
    region = var.region
    kms_key = aws_kms_key.vault.key_id
  })
  filename = var.inventory_file
}