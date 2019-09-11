variable "vswitch_count" {
  type    = number
  default = 3
}

data "alicloud_zones" "zone-data" {}

resource "alicloud_vswitch" "vswitch" {
  count = var.vswitch_count > length(data.alicloud_zones.zone-data.zones) ? length(data.alicloud_zones.zone-data.zones) : var.vswitch_count

  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone = lookup(data.alicloud_zones.zone-data.zones[count.index], "id")
}

output "vswitch_ids" {
  value = alicloud_vswitch.vswitch.*.id
}
