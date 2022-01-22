<center>

# AKS Deployment

<p float="left">
  <img src="https://technofaq.org/wp-content/uploads/2021/11/Azure-logo.png.webp" width="230"/>
  <img src="https://caiodelgado.dev/content/images/2020/04/terraform_d56939b1fa30e9c48acec1ccd8d4e507.png" width="200"/>
  <img src="https://riteshkumarreddykuchukulla.files.wordpress.com/2019/01/vault4-1.png?w=899" width="300"/>
</p>
</center>


## About

A simple example of using the [AKS terraform module](https://registry.terraform.io/modules/Azure/aks/azurerm/latest) with [Hashicorp Vault](https://www.vaultproject.io/).

### Prerequisites

 - You will need to have some instance of Hashicorp Vault up and running.\
 Maybe this [repository](https://github.com/GuhAlex/kind-vault) will help you to set your Vault environment quickly. :grin:

 - You will need to have a [service principal](https://learn.hashicorp.com/tutorials/vault/azure-secrets#create-an-azure-service-principal-and-resource-group) on azure.


 - This service principal needs to have the Microsoft Graph API, with the permissions [here](https://www.vaultproject.io/docs/secrets/azure#ms-graph-permissions).

### Setup  :wrench:

1. Enable the Azure secrets engine and the KV secret engine
```
vault secrets enable azure
vault secrets enable kv
```
2. Set the secrets engine with your azure credentials:
```
vault write azure/config \
    subscription_id=$AZURE_SUBSCRIPTION_ID \
    tenant_id=$AZURE_TENANT_ID \
    client_id=$AZURE_CLIENT_ID \
    client_secret=$AZURE_CLIENT_SECRET \
    use_microsoft_graph_api=true
```
3. Configure role with 1h of TTL and scope to all resources:
```
vault write azure/roles/owner ttl=1h azure_roles=-<<EOF
  [
    {
      "role_name": "Owner",
      "scope":  "/subscriptions/$AZURE_SUBSCRIPTION_ID"
    }
  ]
EOF
```
4. check setup
```
vault read azure/creds/owner
```
5. Enable KV secret engine
```
vault secrets enable kv
```
6. Create a secret with subscription and tenant ID
```
vault kv put kv/azure subscription_id=$AZURE_SUBSCRIPTION_ID tenant_id=$AZURE_TENANT_ID
```
7. Setup terraform
```
terraform init # downlaod all necessary modules
terraform plan
terraform apply
```
