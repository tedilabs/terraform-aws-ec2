###################################################
# IAM Role for Instance Profile
###################################################

module "instance_profile" {
  count = var.default_instance_profile.enabled ? 1 : 0

  source  = "tedilabs/account/aws//modules/iam-role"
  version = "~> 0.30.5"

  name = coalesce(
    var.default_instance_profile.name,
    "ec2-${local.metadata.name}"
  )
  path        = var.default_instance_profile.path
  description = var.default_instance_profile.description

  trusted_service_policies = [
    {
      services = ["ec2.amazonaws.com"]
    }
  ]

  policies = concat(
    [],
    var.default_instance_profile.policies,
  )
  inline_policies = var.default_instance_profile.inline_policies

  instance_profile = {
    enabled = true
  }

  force_detach_policies  = true
  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
  )
}
