output "vpc_id" {
  description = "ID of the SRE VPC"
  value       = aws_vpc.sre_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"

  value = [
    aws_subnet.subnets["public_1"].id,
    aws_subnet.subnets["public_2"].id
  ]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"

  value = [
    aws_subnet.subnets["private_1"].id,
    aws_subnet.subnets["private_2"].id
  ]
}