variable "region" {
  type = string
}

variable "vpc-cidr" {
  default = "172.32.0.0/16"
  description = "The CIDR block for your VPC"
  type = string
}

variable "public-subnet-cidr" {
  default = "172.32.0.0/24"
  description = "Public subnet CIDR"
  type = string
}

variable "private-subnet-1-cidr" {
  default = "172.32.1.0/24"
  description = "Private subnet 1 CIDR"
  type = string
}

variable "private-subnet-2-cidr" {
  default = "172.32.2.0/24"
  description = "Private subnet 2 CIDR"
  type = string
}

variable "private-subnet-3-cidr" {
  default = "172.32.3.0/24"
  description = "Private subnet 3 CIDR"
  type = string
}

variable "my-ip" {
  description = "IP Address from which to get access to the public subnet in CIDR format (usually /32)"
  type = string
}

variable "owner_email" {
  type = string
}

variable "owner_name" {
  type = string
}
