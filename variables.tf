variable "aws_region" {
  description = "AWS region where infrastructure will be deployed"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for the SRE learning VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "learning"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "sre"
}
variable "subnets" {
  description = "Configuration for public and private subnets"

  type = map(object({
    cidr_block = string
    az         = string
    public     = bool
  }))
}