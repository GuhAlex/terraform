provider "vault" {
  address         = var.vault_url
  skip_tls_verify = var.vautl_tls_verify
  token           = var.vault_token
 }


provider "aws" {
  access_key = data.vault_generic_secret.aws.data["access_key"]
  secret_key = data.vault_generic_secret.aws.data["secret_key"]
}



data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


data "vault_generic_secret" "aws" {
  path = var.vault_secret_path
}

data "aws_eks_cluster" "my_eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "my_eks" {
  name = module.eks.cluster_id
}
