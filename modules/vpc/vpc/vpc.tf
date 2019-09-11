variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}

resource "alicloud_vpc" "vpc" {
  name       = var.vpc_name
  cidr_block = var.vpc_cidr
}

output "vpc_id" {
  value = alicloud_vpc.vpc.id
}
