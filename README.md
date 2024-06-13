# bootcamp-vpc
Terraform script to create a new VPC for bootcamp including jumphost and samba host

This script will create

- VPC

- Internet Gateway

- 3 public subnet

- 3 private subnets

- 1 internal security group that allows all instances with the VPC to talk to each other

- 1 external security group for a specific IP address (typically the external IP of an office or home)

- 1 SSL key

- 1 jumphost

- 1 samba host

# Instructions

Clone this repository if not already done so.

        cp terraform.tfvars.template terraform.tfvars
        vi terraform.tfvars # you can also use nano or any another editor
        terraform init
        terraform plan      # this is just for verification and optional
        terraform apply

The output can be recalled with the command

        terraform output

# Hints

- The region and the availability zones need to match, like eu-west-1 and eu-west-1a
- Adjust the name of the bootcamp key to your liking. This is the symbolic name in AWS
- Adjust the root zone to your liking or leave it at bootcamp.confluent.io. It needs to be legal URL. 
- owner-email, owner-name and the cflt values are all tags, and have no significance outside of Confluent
