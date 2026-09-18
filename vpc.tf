resource "aws_vpc" "sre_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "sre-learning-vpc"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}