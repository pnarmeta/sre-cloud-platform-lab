terraform {
  required_version = ">= 1.16.0"
}
module "network" {
  source = "./modules/network"

  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  project_name = var.project_name
  subnets      = var.subnets
}