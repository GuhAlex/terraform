 terraform {
   required_version = ">= 0.13.1"

   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = "~> 3.0"
     }
     local = {
       source  = "hashicorp/local"
       version = "~> 2.1.0"
     }
     kubernetes = {
       source  = "hashicorp/kubernetes"
       version = "~> 2.7.1"
     }
     vault = {
       source  = "hashicorp/vault"
       version = "~> 3.0.0"
     }
     random = {
       source  = "hashicorp/random"
       version = "~> 3.1.0"
     }
   }
 }
