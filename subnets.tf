resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.sre_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "sre-public-subnet-1"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.sre_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "sre-public-subnet-2"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}