resource "alicloud_key_pair" "cluster-key" {
  key_name = "${var.key_name}"
  key_file = "${var.key_output_dir}/worker-key.pem"
}
