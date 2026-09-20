resource "aws_vpc" "sre_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "sre-learning-vpc"
    }
  )
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.sre_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = merge(
    local.common_tags,
    {
      Name = "sre-${split("_", each.key)[0]}-subnet-${split("_", each.key)[1]}"
    }
  )
}

resource "aws_internet_gateway" "sre_igw" {
  vpc_id = aws_vpc.sre_vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "sre-learning-igw"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.sre_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sre_igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "sre-public-route-table"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.sre_vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "sre-private-route-table"
    }
  )
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.subnets["public_1"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.subnets["public_2"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.subnets["private_1"].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.subnets["private_2"].id
  route_table_id = aws_route_table.private.id
}