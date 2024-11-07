terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.4.0"
    }
  }
}

variable "service_clients_file" {
  default = "service_clients.csv"
}

variable "keycloak_admin_user" {
  default = "keycloak"
}

variable "keycloak_admin_password" {
  default = "keycloakpass"
}

variable "keycloak_url" {
  type = string
}

variable "ldap_server" {
  type = string
}

variable "ldap_base" {
  type = string
}

provider "keycloak" {
  client_id     = "admin-cli"
  username      = "tmpadm"
  password      = "secret"
  url           = var.keycloak_url
}

# Add admin user

data "keycloak_realm" "master" {
  realm = "master"
}

resource "keycloak_user" "admin" {
  realm_id = data.keycloak_realm.master.id
  username = var.keycloak_admin_user

  initial_password {
    value = var.keycloak_admin_password
    temporary = false
  }
}

data "keycloak_role" "admin_role" {
  realm_id = data.keycloak_realm.master.id
  name = "admin"
}

resource "keycloak_user_roles" "admin_user_roles" {
  realm_id = data.keycloak_realm.master.id
  user_id = keycloak_user.admin.id

  role_ids = [
    data.keycloak_role.admin_role.id
  ]

  exhaustive = false
}

resource "keycloak_realm" "bootcamp" {
  realm         = "Bootcamp"
  enabled       = true
  display_name  = "Bootcamp Realm"
  display_name_html = "<b>Bootcamp Realm</b"

  login_theme   = "base"
}

locals {
  service_clients = csvdecode(file("/home/ubuntu/terraform/${var.service_clients_file}"))
}

# Add clients

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

# Add LDAP federation

resource "keycloak_ldap_user_federation" "ldap_user_federation" {
  name = "Samba LDAP"
  realm_id = keycloak_realm.bootcamp.id
  enabled = true

  username_ldap_attribute = "sAMAccountName"
  rdn_ldap_attribute      = "cn"
  uuid_ldap_attribute     = "objectGUID"
  user_object_classes     = [
    "person",
    "organizationalPerson",
    "user"
  ]

  connection_url          = var.ldap_server
  users_dn                = "OU=Users,OU=Kafka,${var.ldap_base}"
  bind_dn                 = "CN=Alice Lookingglass,OU=Users,OU=Kafka,${var.ldap_base}"
  bind_credential         = "alice-secret"
  search_scope            = "SUBTREE"
  full_sync_period        = 3600 # 60 minutes
  changed_sync_period     = 60 # 1 minute
}

resource "keycloak_ldap_user_attribute_mapper" "Username" {
  realm_id                = keycloak_realm.bootcamp.id
  ldap_user_federation_id = keycloak_ldap_user_federation.ldap_user_federation.id
  name                    = "username"

  user_model_attribute    = "username"
  ldap_attribute          = "sAMAccountName"
}

resource "keycloak_ldap_user_attribute_mapper" "email" {
  realm_id                = keycloak_realm.bootcamp.id
  ldap_user_federation_id = keycloak_ldap_user_federation.ldap_user_federation.id
  name                    = "email"

  user_model_attribute    = "email"
  ldap_attribute          = "mail"
}

resource "keycloak_ldap_user_attribute_mapper" "firstname" {
  realm_id                = keycloak_realm.bootcamp.id
  ldap_user_federation_id = keycloak_ldap_user_federation.ldap_user_federation.id
  name                    = "first name"

  user_model_attribute    = "firstName"
  ldap_attribute          = "givenName"
}

resource "keycloak_ldap_user_attribute_mapper" "lastname" {
  realm_id                = keycloak_realm.bootcamp.id
  ldap_user_federation_id = keycloak_ldap_user_federation.ldap_user_federation.id
  name                    = "email"

  user_model_attribute    = "lastName"
  ldap_attribute          = "sn"
}
