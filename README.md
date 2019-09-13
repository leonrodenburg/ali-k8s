# Kubernetes on Alibaba Cloud with Terraform

## Modules

Example templates for setting up a fully functional, publicly routable managed Kubernetes cluster on Alibaba Cloud.

Several modules are provided to make your life easier:

| Module               | Description                                                        |
| -------------------- | ------------------------------------------------------------------ |
| `vpc/vpc`            | Creates a VPC with a customizable number of VSwitches              |
| `vpc/security-group` | Creates a security group, optionally allowing all outbound traffic |
| `vpc/nat`            | Installs a NAT gateway in the specified VPC with SNAT enabled      |
| `cs/k8s/managed`     | Sets up a managed Kubernetes cluster                               |

## Getting started

Before you can deploy, you need to enable several services in your account on Alibaba Cloud. Log in to your account and
find 'Container Service'. Prompts will show up that several of the necessary services have not been enabled yet. Click through
the prompts to enable them. If you don't see any prompts when you go to the Container Service console, you are probably fine.

Next, create a file called `terraform.tfvars` with the following contents:

```
access_key = "YOUR_ACCESS_KEY_HERE"
secret_key = "YOUR_SECRET_KEY_HERE"
region     = "eu-central-1"
```

Replace `access_key` and `secret_key` with your credentials. Also, update the region if you want to.

Now, you are ready to deploy. An example cluster using the modules mentioned above has been defined in `main.tf`.
To deploy, run these commands on the CLI:

```
mkdir .kube
terraform plan -out tfplan
terraform apply tfplan
```

After a few minutes your managed Kubernetes cluster should be up and running! Keys and cluster certificates are
stored in `.kube` by default. You can use these to connect to the Kubernetes API server.
