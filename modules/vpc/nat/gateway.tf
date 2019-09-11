variable "vpc_id" {}
variable "name" {}
variable "vswitch_ids" {
  type = list(string)
}
variable "specification" {
  type    = string
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
  count             = length(var.vswitch_ids)
  snat_table_id     = alicloud_nat_gateway.nat-gateway.snat_table_ids
  source_vswitch_id = var.vswitch_ids[count.index]
  snat_ip           = alicloud_eip.eip.ip_address
}
