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
