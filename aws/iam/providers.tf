provider "vault" {
  address         = var.vault_url
  skip_tls_verify = var.vautl_tls_verify
  token           = var.vault_token
 }

provider "aws" {
  region     = var.aws_region
  access_key = data.vault_generic_secret.aws.data["access_key"]
  secret_key = data.vault_generic_secret.aws.data["secret_key"]
}

data "vault_generic_secret" "aws" {
  path = var.vault_secret_path
}
