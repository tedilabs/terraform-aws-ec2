locals {
  metadata = {
    package = "terraform-aws-ec2"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# Recycle Bin Retention Rule
###################################################

# INFO: A retention rule has no name attribute. `name` is kept as the `Name` tag.
resource "aws_rbin_rule" "this" {
  region = var.region

  description   = var.description
  resource_type = var.resource_type

  retention_period {
    retention_period_value = var.retention_period
    retention_period_unit  = "DAYS"
  }

  # Tag-level retention rule
  dynamic "resource_tags" {
    for_each = var.resource_tags

    content {
      resource_tag_key   = resource_tags.key
      resource_tag_value = resource_tags.value
    }
  }

  # Region-level retention rule
  dynamic "exclude_resource_tags" {
    for_each = var.exclude_resource_tags

    content {
      resource_tag_key   = exclude_resource_tags.key
      resource_tag_value = exclude_resource_tags.value
    }
  }

  dynamic "lock_configuration" {
    for_each = var.lock.enabled ? [var.lock] : []

    content {
      unlock_delay {
        unlock_delay_value = lock_configuration.value.unlock_delay
        unlock_delay_unit  = "DAYS"
      }
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
