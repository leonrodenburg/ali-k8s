# Alibaba Cloud Kubernetes cluster with Terraform

Example templates for setting up a fully functional, publicly routable managed Kubernetes cluster on Alibaba Cloud.

Several modules are provided to make your life easier:

| Module               | Description                                                        |
| -------------------- | ------------------------------------------------------------------ |
| `vpc/vpc`            | Creates a VPC with a customizable number of VSwitches              |
| `vpc/security-group` | Creates a security group, optionally allowing all outbound traffic |
| `vpc/nat`            | Installs a NAT gateway in the specified VPC with SNAT enabled      |
| `cs/k8s/managed`     | Sets up a managed Kubernetes cluster                               |