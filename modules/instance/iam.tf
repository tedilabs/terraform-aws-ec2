###################################################
# IAM Role for Instance Profile
###################################################

module "instance_profile" {
  source  = "tedilabs/account/aws//modules/iam-role"
  version = "~> 0.22.0"

  count = try(var.instance_profile.enabled, true) ? 1 : 0

  name        = try(var.instance_profile.name, "ec2-${local.metadata.name}")
  path        = try(var.instance_profile.path, "/")
  description = try(var.instance_profile.description, "Instance Profile for EC2 Instance (${local.metadata.name}).")

  trusted_services = ["ec2.amazonaws.com"]

  assumable_roles = try(var.instance_profile.assumable_roles, [])
  policies        = try(var.instance_profile.policies, [])
  inline_policies = try(var.instance_profile.inline_policies, {})

  instance_profile_enabled = true

  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
  )
}
