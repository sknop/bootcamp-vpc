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
  type = list
}

variable "public-subnet-cidr" {
  default = "172.32.0.0/24"
  description = "Public subnet CIDR"
  type = string
}

variable "private-subnets-cidr" {
  description = "Private subnet CIDR"
  type = list
}

variable "bootcamp-key-name" {
  default = "bootcamp-partner-key"
  description = "Name of key in AWS"
  type = string
}

variable "my-ip" {
  description = "IP Address from which to get access to the public subnet in CIDR format (usually /32)"
  type = string
}

#variable "owner_email" {
#  type = string
#}

#variable "owner_name" {
#  type = string
#}
