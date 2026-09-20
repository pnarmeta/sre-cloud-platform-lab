moved {
  from = aws_vpc.sre_vpc
  to   = module.network.aws_vpc.sre_vpc
}

moved {
  from = aws_internet_gateway.sre_igw
  to   = module.network.aws_internet_gateway.sre_igw
}

moved {
  from = aws_route_table.public
  to   = module.network.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.network.aws_route_table.private
}

moved {
  from = aws_subnet.subnets["public_1"]
  to   = module.network.aws_subnet.subnets["public_1"]
}

moved {
  from = aws_subnet.subnets["public_2"]
  to   = module.network.aws_subnet.subnets["public_2"]
}

moved {
  from = aws_subnet.subnets["private_1"]
  to   = module.network.aws_subnet.subnets["private_1"]
}

moved {
  from = aws_subnet.subnets["private_2"]
  to   = module.network.aws_subnet.subnets["private_2"]
}

moved {
  from = aws_route_table_association.public_1
  to   = module.network.aws_route_table_association.public_1
}

moved {
  from = aws_route_table_association.public_2
  to   = module.network.aws_route_table_association.public_2
}

moved {
  from = aws_route_table_association.private_1
  to   = module.network.aws_route_table_association.private_1
}

moved {
  from = aws_route_table_association.private_2
  to   = module.network.aws_route_table_association.private_2
}