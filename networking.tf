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
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.subnets["public_1"].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.subnets["public_2"].id
  route_table_id = aws_route_table.public.id
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
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.subnets["private_1"].id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.subnets["private_2"].id
  route_table_id = aws_route_table.private.id
}