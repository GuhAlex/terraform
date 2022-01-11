terraform {
  required_version = ">= 0.13.1"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "< 4.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0.0"
    }
  }
}
