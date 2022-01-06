################################################################################
# VAULT PROVISONER VARIABLES
################################################################################
variable vault_secret_path {
  type    = string
  default = "kv/azure"
}

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
# RESOURCE GROUPS VARIABLES
################################################################################
variable az_resource_group {
  type    = string
  default = "aks-test"
}

variable region {
  type    = string
  default = "brazilsouth"
}
################################################################################
# NETWORK MODULE VARIABLES
################################################################################
variable address_spaces {
  type    = list(string)
  default = ["11.0.0.0/16"]
}

variable subnet_names {
  type    = list(string)
  default = ["subnet1"]
}

variable subnet_prefixes {
  type    = list(string)
  default = ["11.0.1.0/24"]
}
################################################################################
# AKS MODULE VARIABLES
################################################################################
variable kube_dns_ip {
  type    = string
  default = "11.240.0.10"
}

variable docker_bridge_ip {
  type    = string
  default = "170.10.0.1/16"
}

variable k8s_service_cidr {
  type    = string
  default = "11.240.0.0/16"
}
