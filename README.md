# bootcamp-vpc
Terraform script to create a new VPC for bootcamp including jumphost and samba host

Will create

- VPC

- Internet Gateway

- 1 public subnet

- 3 private subnets

- 1 internal security group that allows all instances with the VPC to talk to each other

- 1 external security group for a specific IP address (typically the external IP of an office or home)

- 1 jumphost

- 1 samba host
