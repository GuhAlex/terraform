# AWS IAM Terraform Module

---

## About

A simple example of using the [IAM terraform module](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest/). \
In this demo, two IAM users with tree groups are created. Each group assumable predefined IAM roles (admin, poweruser and readonly).\
Also, the Vault Provider is used to store the AWS Credentials. \
Maybe this [repository](https://github.com/GuhAlex/kind-vault) will help you to set your Vault environment quickly. :grin:

## Setup :wrench:
```
terraform init
terraform plan
terraform apply
```
