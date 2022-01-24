<center>

# EKS Deployment

<p float="left">
  <img src="https://logos-world.net/wp-content/uploads/2021/08/Amazon-Web-Services-AWS-Logo.png" width="230"/>
  <img src="https://caiodelgado.dev/content/images/2020/04/terraform_d56939b1fa30e9c48acec1ccd8d4e507.png" width="200"/>
  <img src="https://riteshkumarreddykuchukulla.files.wordpress.com/2019/01/vault4-1.png?w=899" width="300"/>
</p>
</center>

## About

A simple example of using the [EKS terraform module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) with [Hashicorp Vault](https://www.vaultproject.io/).

### Prerequisites

 - You will need to have some instance of Hashicorp Vault up and running.\
 Maybe this [repository](https://github.com/GuhAlex/kind-vault) will help you to set your Vault environment quickly. :grin:

### Setup  :wrench:
1. Enable the AWS secrets engine
```
vault secrets enable aws
```
2. Config the credentials that Vault uses to generate the IAM credentials on AWS
```
vault write aws/config/root \
    access_key=AKIAJWVN5Z4FOFT7NLNA \
    secret_key=R4nm063hgMVo4BTT5xOs5nHLeLXA6lar7ZJ3Nt0i \
    region=us-east-2
```
> #### Warning :warning:
>Do not use your AWS root account credentials. Instead generate a dedicated user or role.


3. Config the role that will be used on generate credential
```
vault write aws/roles/admin \
    credential_type=iam_user \
    policy_document=-<<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "*",
          "Resource": "*"
        }
      ]
    }
EOF
```
4. check setup
```
vault read aws/creds/admin
```
5. Setup terraform
```
terraform init # download all necessary modules
terraform plan
terraform apply
```
