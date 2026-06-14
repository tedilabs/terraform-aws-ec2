data "aws_subnet" "this" {
  count = var.default_security_group.enabled ? 1 : 0

  id = var.subnet

  lifecycle {
    precondition {
      condition     = var.subnet != null
      error_message = "`subnet` is required when `default_security_group.enabled` is `true`, because the security group is created in the subnet's VPC. The default VPC is not supported."
    }
  }
}

locals {
  vpc_id = var.default_security_group.enabled ? data.aws_subnet.this[0].vpc_id : null

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
  version = "~> 1.0.0"

  count = var.default_security_group.enabled ? 1 : 0

  region = var.region

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
  resource_group = {
    enabled = false
  }
  module_tags_enabled = false

  tags = merge(
    local.module_tags,
    var.tags,
  )
}
