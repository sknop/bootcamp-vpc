variable "region" {
  type = string
}

variable "vpc-cidr" {
  default = "172.32.0.0/16"
  description = "The CIDR block for your VPC"
  type = string
}

variable "availability-zones" {
  description = "The availability zones for this region"
  type = list(string)
}

variable "public-availability-zone" {
  description = "The availability zone for the public subnet"
  type = list(string)
}

variable "public-subnet-cidr" {
  description = "Public subnet CIDR"
  type = list(string)
}

variable "private-subnets-cidr" {
  description = "Private subnet CIDR"
  type = list(string)
}

variable "bootcamp-key-name" {
  default = "bootcamp-key"
  description = "Name of key in AWS"
  type = string
}

variable "my-ip" {
  description = "IP Address from which to get access to the public subnet in CIDR format (usually /32)"
  type = string
  default = ""
}

variable "samba-instance-type" {
  description = "AWS instance type used for samba instance"
  default = "t3.large"
}

variable "jumphost-instance-type" {
  description = "AWS instance type used for jumphost instance"
  default = "t3.micro"
}

variable "owner_email" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "cflt_environment" {
  default = "prod"
}

variable "cflt_partition" {
  default = "sales"
}

variable "cflt_managed_by" {
  type = string
}

variable "cflt_managed_id" {
  default = "user"
}

variable "cflt_service" {
  description = "This is the theatre of operation, like EMEA or APAC"
  type = string
}

variable "keycloak_admin_user" {
  default = "keycloak"
}

variable "keycloak_admin_secret" {
  default = "keycloakpass"
}

variable "vault-unseal-key-alias" {
  description = "A alias name for AWS KMS Key. Needs to be unique within a region and start with alias/"
  type = string
  default = "alias/vault-unseal-key"
}

variable "root-zone" {
  type = string
}

# Let's make it configurable
variable "checkip-address" {
  type = string
  default = "https://icanhazip.com"
}
