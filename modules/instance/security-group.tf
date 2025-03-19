data "aws_vpc" "default" {
  count = var.subnet == null ? 1 : 0

  default = true
}

data "aws_subnet" "this" {
  count = var.subnet != null ? 1 : 0

  id = var.subnet
}

locals {
  vpc_id = (var.subnet != null
    ? data.aws_subnet.this[0].vpc_id
    : data.aws_vpc.default[0].id
  )

  security_groups = (var.default_security_group.enabled
    ? concat(module.security_group[*].id, var.security_groups)
    : var.security_groups
  )
}


###################################################
# Security Group
###################################################

module "security_group" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "~> 0.32.0"

  count = var.default_security_group.enabled ? 1 : 0

  name        = coalesce(var.default_security_group.name, local.metadata.name)
  description = var.default_security_group.description
  vpc_id      = local.vpc_id

  ingress_rules = [
    for i, rule in var.default_security_group.ingress_rules :
    merge(rule, {
      id = coalesce(rule.id, "ec2-instance-${i}")
    })
  ]
  egress_rules = [
    for i, rule in var.default_security_group.egress_rules :
    merge(rule, {
      id = coalesce(rule.id, "ec2-instance-${i}")
    })
  ]

  revoke_rules_on_delete = true
  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
  )
}
