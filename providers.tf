terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.4.0"
    }
    curl = {
      version = "1.0.2"
      source  = "anschoewe/curl"
    }
  }
}
