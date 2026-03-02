resource "aws_route53_zone" "private" {
  name = var.root-zone # "bootcamp.confluent.io"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
