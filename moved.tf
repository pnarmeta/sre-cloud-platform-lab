moved {
  from = aws_subnet.public_1
  to   = aws_subnet.subnets["public_1"]
}

moved {
  from = aws_subnet.public_2
  to   = aws_subnet.subnets["public_2"]
}

moved {
  from = aws_subnet.private_1
  to   = aws_subnet.subnets["private_1"]
}

moved {
  from = aws_subnet.private_2
  to   = aws_subnet.subnets["private_2"]
}