

################################################################################
# VAULT PROVISONER VARIABLES
################################################################################
variable vault_secret_path {
  type    = string
  default = "kv/aws"
}

variable vault_url {
  type    = string
  default = "http://vault.local"
}

variable vault_token {
  type    = string
  default = "s.GoikUiID3DxiPqjyRXnykIIb"
}

variable vautl_tls_verify {
  default = true
}

################################################################################
# AWS PROVISONER VARIABLES
################################################################################
variable aws_region {
  type    = string
  default = "us-east-1"
}

################################################################################
# Node Groups Modules Variables
################################################################################
variable instance_types {
  type    = list(string)
  default = ["t3.large"]
}

################################################################################
# EKS Module Variables
################################################################################
variable map_roles {
  description = "Additional IAM roles to add to the aws-auth configmap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::707467741717:policy/admins"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

################################################################################
# VPC Module Variables
################################################################################
variable private_subnets {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable public_subnets {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable cidr {
  type    = string
  default = "10.0.0.0/16"
}
