resource "aws_route53_zone" "private" {
  name = var.root-zone # "bootcamp.confluent.io"

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}
