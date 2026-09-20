output "vpc_id" {
  description = "ID of the SRE VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.network.private_subnet_ids
}
output "web_server_instance_id" {
  description = "ID of the EC2 web server"
  value       = module.compute.instance_id
}

output "web_server_public_ip" {
  description = "Public IP address of the EC2 web server"
  value       = module.compute.public_ip
}