locals {
  name            = "my_eks-${random_string.suffix.result}"
  cluster_version = "1.21"
  region          = var.aws_region
}

################################################################################
# EKS Module
################################################################################
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = local.name
  cluster_version = local.cluster_version

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  node_groups = {
    milestones = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types = var.instance_types

      additional_tags = {
        ExtraTag = "Node-Group1"
      }
    }

    alabama = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types = var.instance_types

      additional_tags = {
        ExtraTag = "Node-Group2"
      }
    }
  }

  map_roles    = var.map_roles
  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# Supporting resources
################################################################################

data "aws_availability_zones" "available" {
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name                 = local.name
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = "1"
  }

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}
