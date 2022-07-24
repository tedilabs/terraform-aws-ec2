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

locals {
  strategy = {
    "CLUSTER"   = "cluster"
    "PARTITION" = "partition"
    "SPREAD"    = "spread"
  }
}


###################################################
# Placement Group for EC2 Instances
###################################################

resource "aws_placement_group" "this" {
  name     = var.name
  strategy = local.strategy[var.strategy]
  partition_count = (var.strategy == "PARTITION"
    ? var.partition_size
    : null
  )
  spread_level = (var.strategy == "SPREAD"
    ? lower(var.spread_level)
    : null
  )

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
