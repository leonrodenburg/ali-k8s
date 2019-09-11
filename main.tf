variable "access_key" {}
variable "secret_key" {}
variable "region" {}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "vpc" {
  source = "./modules/vpc/vpc"

  vpc_cidr      = "10.0.0.0/8"
  vpc_name      = "k8s-vpc"
  vswitch_count = 3
}

module "security-group" {
  source = "./modules/vpc/security-group"

  name         = "default"
  vpc_id       = module.vpc.vpc_id
  allow_egress = true
}

module "nat-gateway" {
  source = "./modules/vpc/nat"

  name        = "k8s-nat"
  vpc_id      = module.vpc.vpc_id
  vswitch_ids = module.vpc.vswitch_ids
}
