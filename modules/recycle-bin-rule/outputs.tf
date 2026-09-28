output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_rbin_rule.this.region
}

output "id" {
  description = "The ID of the retention rule."
  value       = aws_rbin_rule.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the retention rule."
  value       = aws_rbin_rule.this.arn
}

output "name" {
  description = "The name of the retention rule."
  value       = local.metadata.name
}

output "description" {
  description = "The description of the retention rule."
  value       = aws_rbin_rule.this.description
}

output "status" {
  description = "The state of the retention rule. Only retention rules in the `AVAILABLE` state retain resources."
  value       = upper(aws_rbin_rule.this.status)
}

output "resource_type" {
  description = "The resource type retained by the retention rule."
  value       = aws_rbin_rule.this.resource_type
}

output "retention_period" {
  description = "The number of days to retain deleted resources in the Recycle Bin."
  value       = one(aws_rbin_rule.this.retention_period[*].retention_period_value)
}

output "filter" {
  description = <<EOF
  The configuration to filter the resources to retain by resource tags.
    `mode` - The mode to filter the resources. `INCLUSION` or `EXCLUSION`.
    `resource_tags` - A map of resource tags to include or exclude, according to `mode`.
  EOF
  value = {
    mode = var.filter.mode
    resource_tags = (var.filter.mode == "INCLUSION"
      ? {
        for tag in aws_rbin_rule.this.resource_tags :
        tag.resource_tag_key => tag.resource_tag_value
      }
      : {
        for tag in aws_rbin_rule.this.exclude_resource_tags :
        tag.resource_tag_key => tag.resource_tag_value
      }
    )
  }
}

output "lock" {
  description = <<EOF
  The lock configuration of the retention rule.
    `enabled` - Whether the retention rule is locked.
    `unlock_delay` - The number of days to wait after the rule is unlocked before it can be modified or deleted.
  EOF
  value = {
    enabled = length(aws_rbin_rule.this.lock_configuration) > 0
    unlock_delay = (length(aws_rbin_rule.this.lock_configuration) > 0
      ? one(aws_rbin_rule.this.lock_configuration[0].unlock_delay[*].unlock_delay_value)
      : null
    )
  }
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}

# output "debug" {
#   value = {
#     for k, v in aws_rbin_rule.this :
#     k => v
#     if !contains(["region", "id", "arn", "description", "resource_type", "resource_tags", "tags", "tags_all", "timeouts", "retention_period", "exclude_resource_tags", "status", "", "lock_end_time", "lock_state", "lock_configuration"], k)
#   }
# }
