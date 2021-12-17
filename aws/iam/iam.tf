# IAM Users
module "iam_user1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 4.3"

  name          = var.user1

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_user2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 4.3"

  name          = var.user2

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

#IAM assumable roles (admin, poweruser, readonly)
data "aws_caller_identity" "current" {}

module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "~> 4.3"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
  ]

  create_admin_role = true
  admin_role_name   = "administrator"

  create_poweruser_role = true
  poweruser_role_name   = "developer"

  create_readonly_role       = true
  readonly_role_name         = "viewers"
  readonly_role_requires_mfa = false
}

# Creates IAM group with specified IAM policies, and add users into a group.

# Admin group
module "iam_group_admins" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "admins"

  assumable_roles = [module.iam_assumable_roles.admin_iam_role_arn]

  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]
}

module "iam_group_developers" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "developers"

  assumable_roles = [module.iam_assumable_roles.poweruser_iam_role_arn]

  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]
}

module "iam_group_viewers" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "viewers"

  assumable_roles = [module.iam_assumable_roles.readonly_iam_role_arn]

  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]
}
