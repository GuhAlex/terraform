provider "vault" {
  address         = var.vault_url
  skip_tls_verify = var.vautl_tls_verify
  token           = var.vault_token
 }

 data "vault_generic_secret" "azure" {
   path = var.vault_secret_path
 }

provider "azurerm" {
  features {}
  subscription_id = data.vault_generic_secret.azure.data["subscription_id"]
  client_id       = data.vault_generic_secret.azure.data["client_id"]
  client_secret   = data.vault_generic_secret.azure.data["client_secret"]
  tenant_id       = data.vault_generic_secret.azure.data["tenant_id"]
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}


provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}
