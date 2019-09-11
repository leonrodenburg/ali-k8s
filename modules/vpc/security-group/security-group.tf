variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "allow_egress" {
  type    = bool
  default = true
}

resource "alicloud_security_group" "security-group" {
  name   = var.name
  vpc_id = var.vpc_id
}

resource "alicloud_security_group_rule" "egress-allow-all" {
  count             = var.allow_egress == true ? 1 : 0
  security_group_id = alicloud_security_group.security-group.id

  type        = "egress"
  ip_protocol = "all"
  nic_type    = "intranet"
  port_range  = "-1/-1"
  policy      = "accept"
  cidr_ip     = "0.0.0.0/0"
}

output "security_group_id" {
  value = alicloud_security_group.security-group.id
}
