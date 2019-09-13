variable "vpc_id" {}
variable "name" {}
variable "vswitches" {}
variable "specification" {
  default = "Small"
}

resource "alicloud_nat_gateway" "nat-gateway" {
  vpc_id        = var.vpc_id
  specification = var.specification
  name          = var.name
}

resource "alicloud_eip" "eip" {
  name      = var.name
  bandwidth = "25"
}

resource "alicloud_eip_association" "eip-association" {
  allocation_id = alicloud_eip.eip.id
  instance_id   = alicloud_nat_gateway.nat-gateway.id
}

resource "alicloud_snat_entry" "snat" {
  count             = length(var.vswitches)
  snat_table_id     = alicloud_nat_gateway.nat-gateway.snat_table_ids
  source_vswitch_id = var.vswitches[count.index].id
  snat_ip           = alicloud_eip.eip.ip_address
}
