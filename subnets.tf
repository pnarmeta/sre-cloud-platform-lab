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