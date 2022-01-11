provider "vault" {
  address         = var.vault_url
  skip_tls_verify = var.vautl_tls_verify
  token           = var.vault_token
 }

 data "vault_generic_secret" "gcp" {
   path = var.vault_secret_path
 }

 provider "google" {
   project      = var.project
   region       = var.region
   zone         = var.zone
   access_token = data.vault_generic_secret.gcp.data["token"]
 }

 provider "google-beta" {
   project      = var.project
   region       = var.region
   zone         = var.zone
   access_token = data.vault_generic_secret.gcp.data["token"]
 }


# data "google_client_config" "default" {}

 provider "kubernetes" {
   host                   = "https://${module.gke.endpoint}"
   token                  = data.vault_generic_secret.gcp.data["token"]
   cluster_ca_certificate = base64decode(module.gke.ca_certificate)
 }

 provider "helm" {
   kubernetes {
     host                   = "https://${module.gke.endpoint}"
     token                  = data.vault_generic_secret.gcp.data["token"]
     cluster_ca_certificate = base64decode(module.gke.ca_certificate)
   }
 }
