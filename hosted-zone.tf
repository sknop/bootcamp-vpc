resource "aws_route53_zone" "private" {
  name = "bootcamp.confluent.io"

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}
