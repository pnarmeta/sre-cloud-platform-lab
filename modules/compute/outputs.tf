output "security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_server.id
}
output "instance_profile_name" {
  description = "IAM instance profile used by EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
output "instance_id" {
  description = "ID of the EC2 web server"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP address of the EC2 web server"
  value       = aws_instance.web_server.public_ip
}