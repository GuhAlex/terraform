# GCP GKE Deployment

---

## About

A simple example of using the [GKE terraform module](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest). \
In addition, one deployment through the [helm provider](https://registry.terraform.io/providers/hashicorp/helm/latest) are added to the cluster. \
The [Hashcorp Vault](https://www.vaultproject.io/) is used to generate OAuth access token for authenticate on GCLOUD through [gcp secret engine](https://www.vaultproject.io/docs/secrets/gcp).\
These tokens are accessed through the [Vault Provider](https://registry.terraform.io/providers/hashicorp/vault/latest).


### Requeriments

 - You will need to have some instance of Hashicorp Vault up and running.\
 Maybe this [repository](https://github.com/GuhAlex/kind-vault) will help you to set your Vault environment quickly. :grin:

 - You need to have some project created and [credentials.json](https://cloud.google.com/docs/authentication/getting-started) file of your GCP account to setup Vault [GCP Engine secret.](https://www.vaultproject.io/docs/secrets/gcp)

 > #### Warning :warning:
 >We are not going to use organization in this demo, so we have to create our own project manually first. \
 If you have a organization on your GCP , maybe you will be able to use this example [simple_project](https://github.com/terraform-google-modules/terraform-google-project-factory/blob/v11.3.0/examples/project_services/main.tf)

----
## Setup Vault :wrench:


Enable gcp secret engine:
```
vault secrets enable gcp
```
Configure the secrets engine with yours credentials account:
```
vault write gcp/config credentials=@credentials.json
```
create policy:
```
vault policy write roleset-policy roleset.hcl
```
configure a static account that generates OAuth2 access tokens, with bindings file:
```
vault write gcp/static-account/token-account service_account_email="miles-davis@project1-337622.iam.gserviceaccount.com" secret_type="access_token" token_scopes="https://www.googleapis.com/auth/cloud-platform" bindings=@mybindings.hcl
```

Download all necessary modules. plan and apply terraform files.
```
terraform init
terraform plan
terraform apply
```
