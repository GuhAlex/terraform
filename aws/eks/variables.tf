################################################################################
# VAULT PROVISONER VARIABLES
################################################################################
variable vault_url {
  type    = string
  default = "http://vault.local"
}

variable vault_token {
  type    = string
  default = ""
}

variable vautl_tls_verify {
  default = true
}

################################################################################
# AWS PROVISONER VARIABLES
################################################################################
variable aws_region {
  type    = string
  default = "us-east-2"
}

################################################################################
# Node Groups Modules Variables
################################################################################
variable instance_types {
  type    = list(string)
  default = ["t3.large"]
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
