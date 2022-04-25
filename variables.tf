variable "region" {
  type = string
}

variable "vpc-cidr" {
  default = "172.32.0.0/16"
  description = "The CIDR block for your VPC"
  type = string
}

variable "public-subnet" {
  description = "Public Subnet"
  type = object({
    name = string
    cidr_block = string
    availability_zone = string
  })
}

variable "private-subnets" {
  description = "Map of Private Subnets"
  type = list(object({
    name = string
    cidr_block = string
    availability_zone = string
  }))
}

variable "owner_email" {
  type = string
}

variable "owner_name" {
  type = string
}
