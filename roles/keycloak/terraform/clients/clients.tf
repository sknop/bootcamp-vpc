terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.4.0"
    }
  }
}

variable "realm_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

resource "keycloak_openid_client" "client" {
  realm_id = var.realm_id
  client_id = var.client_id

  name = var.name
  description = var.description
  enabled = true

  login_theme = "keycloak"

  access_type = "CONFIDENTIAL"
  service_accounts_enabled = true

  client_secret = var.client_secret
}
