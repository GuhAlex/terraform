################################################################################
# VAULT PROVISONER VARIABLES
################################################################################
variable vault_secret_path {
  type    = string
  default = "gcp/static-account/token-account/token"
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
# GCP VARIABLES
################################################################################
variable project {
  type    = string
  default = ""
}

variable region {
  type    = string
  default = "us-central1"
}

variable zone {
  type    = string
  default = "us-east1-b"
}
################################################################################
# NETWORK Module VARIABLES
################################################################################
variable network {
  type    = string
  default = "tutu-vpc"
}

variable subnetwork {
  type    = string
  default = "subnet-gke-1"
}

variable subnet_ip {
  type    = string
  default = "10.0.0.0/17"
}

variable ip_range_pods_name {
  type    = string
  default = "range-pods"
}

variable ip_cidr_ranges_0 {
  type    = string
  default = "192.168.0.0/18"
}

variable ip_range_services_name {
  type    = string
  default = "range-services"
}

variable ip_cidr_range_1 {
  type    = string
  default = "192.168.64.0/18"
}
################################################################################
# GKE VARIABLES
################################################################################
variable gke_name {
  type    = string
  default = "tutu"
}

variable gke_zone {
  type    = list(string)
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
################################################################################
# GKE Node Pools VARIABLES
################################################################################
variable gke_node_pool {
  type    = string
  default = "default"
}

variable machine_type {
  type    = string
  default = "e2-medium"
}

variable disk_type {
  type    = string
  default = "pd-balanced"
}

variable image_type {
  type    = string
  default = "COS"
}

variable service_account {
  type    = string
  default = "miles-davis@project1-337622.iam.gserviceaccount.com"
}
