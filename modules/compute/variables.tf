variable "vpc_id" {
  description = "VPC where compute resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the EC2 instance will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}