terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.4.0"
    }
  }
}

variable "service_clients_file" {
  default = "service_clients.csv"
}

provider "keycloak" {
  client_id     = "admin-cli"
  username      = var.keycloak_admin_user
  password      = var.keycloak_admin_secret
  url           = "https://${aws_instance.sambahost.public_dns}:8443"
}

resource "keycloak_realm" "bootcamp" {
  realm         = "Bootcamp"
  enabled       = true
  display_name  = "Bootcamp Realm"
  display_name_html = "<b>Bootcamp Realm</b"

  login_theme   = "base"

  depends_on = [
    null_resource.ansible-playbook
  ]
}

locals {
  service_clients = csvdecode(file("${path.module}/${var.service_clients_file}"))
}

module "clients" {
  count = length(local.service_clients)

  source = "./clients"

  realm_id = keycloak_realm.bootcamp.id
  client_id = element(local.service_clients, count.index).client_id
  name = element(local.service_clients, count.index).name
  description = element(local.service_clients, count.index).description
  client_secret = element(local.service_clients, count.index).client_secret
}

resource "keycloak_openid_client" "c3_sso_login" {
  realm_id = keycloak_realm.bootcamp.id
  client_id = "c3_sso_login"

  name = "Control Center SSO login"
  enabled = true

  login_theme = "keycloak"

  access_type = "CONFIDENTIAL"

  standard_flow_enabled = true
  direct_access_grants_enabled = true
  service_accounts_enabled = true

  valid_redirect_uris = [
    "https://oauth.pstmn.io/v1/callback"
  ]
  valid_post_logout_redirect_uris = [
    "+"
  ]
  client_secret = "c3_sso_login_secret"
}
