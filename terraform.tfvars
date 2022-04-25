region = "eu-west-1"
vpc-cidr = "172.32.0.0/16"

public-subnet-cidr = "172.32.0.0/24"
private-subnet-1-cidr = "172.32.1.0/24"
private-subnet-2-cidr = "172.32.2.0/24"
private-subnet-3-cidr = "172.32.3.0/24"

private-subnets = [
    {
        "name" = "private-subnet-1",
        "cidr_block" = "172.32.1.0/24",
        "availability_zone" = "eu-west-1a"
    },
    {
        "name" = "private-subnet-2",
        "cidr_block" = "172.32.2.0/24",
        "availability_zone" = "eu-west-1a"
    },
    {
        "name" = "private-subnet-3",
        "cidr_block" = "172.32.3.0/24",
        "availability_zone" = "eu-west-1a"
    }
]

owner_email = "sven@confluent.io"
owner_name = "Sven Erik Knop"
