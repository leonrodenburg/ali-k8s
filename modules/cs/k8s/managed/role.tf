resource "alicloud_ram_role" "k8s-role" {
  name     = "AliyunCSKubernetesAuditRole"
  document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "cs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description = "Allows Kubernetes to access other cloud resources"
  force = true
}

resource "alicloud_ram_role_policy_attachment" "k8s-audit-policy" {
  role_name = alicloud_ram_role.k8s-role.name

  policy_name = "AliyunCSKubernetesAuditRolePolicy"
  policy_type = "System"
}
