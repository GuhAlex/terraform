# Azure AKS Deployment

---

## About

A simple example of using the [AKS terraform module](https://registry.terraform.io/modules/Azure/aks/azurerm/latest). \
In addition, two deployments through the [helm provider](https://registry.terraform.io/providers/hashicorp/helm/latest) are added to the cluster. \
The Vault Provider is used to store the Azure Credentials. \
Maybe this [repository](https://github.com/GuhAlex/kind-vault) will help you to set your Vault environment quickly. :grin:

## Setup :wrench:
```
terraform init
terraform plan
terraform apply
```
