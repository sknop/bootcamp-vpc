resource "null_resource" "ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml"
  }
  depends_on = [
    aws_instance.jumphost,
    aws_instance.sambahost,
    aws_kms_key.vault,
    aws_route.public_internet_gateway,
  ]
}

