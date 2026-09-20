variable "vpc_cidr" {
  description = "CIDR block for the VPC"
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

variable "subnets" {
  description = "Configuration for public and private subnets"

  type = map(object({
    cidr_block = string
    az         = string
    public     = bool
  }))
}