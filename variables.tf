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

variable "root-zone" {
  type = string
}