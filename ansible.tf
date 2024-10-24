resource "null_resource" "ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml"
  }

  triggers = {
    sambahost_id = aws_instance.sambahost.id
    jumphost_id = aws_instance.jumphost.id
  }

  depends_on = [
    aws_instance.jumphost,
    aws_instance.sambahost,
    aws_kms_key.vault,
    aws_route.public_internet_gateway,
  ]
}

