provider "aws" {
  region = var.region
    default_tags {
      tags = {
        Customer = "Confluent"
        Scope    = "Bootcamp"
        Owner    = "Luca Corsini"
      }
   }
}
