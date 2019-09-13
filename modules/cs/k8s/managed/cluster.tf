variable "name" {}
variable "vswitches" {}

variable "pod_cidr" {
  default = "172.20.0.0/16"
}
variable "service_cidr" {
  default = "172.21.0.0/20"
}

variable "worker_number" {
  default = 3
}

data "alicloud_instance_types" "workers" {
  availability_zone = var.vswitches[0].availability_zone
  cpu_core_count    = 1
  memory_size       = 2
}

resource "alicloud_cs_managed_kubernetes" "cluster" {
  depends_on = [alicloud_ram_role_policy_attachment.k8s-audit-policy]

  name            = var.name
  vswitch_ids     = var.vswitches[*].id
  new_nat_gateway = false
  key_name        = alicloud_key_pair.cluster-key.key_name

  pod_cidr              = var.pod_cidr
  service_cidr          = var.service_cidr
  slb_internet_enabled  = true
  install_cloud_monitor = true

  worker_number = var.worker_number
  worker_instance_types = [
    for i in range(var.worker_number) : data.alicloud_instance_types.workers.instance_types[0].id
  ]

  kube_config     = "${var.key_output_dir}/config"
  client_cert     = "${var.key_output_dir}/client-cert.pem"
  client_key      = "${var.key_output_dir}/client-key.pem"
  cluster_ca_cert = "${var.key_output_dir}/cluster-ca-cert.pem"
}
