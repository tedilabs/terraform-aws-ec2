output "id" {
  description = "The ID of the placement group."
  value       = aws_placement_group.this.placement_group_id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the placement group."
  value       = aws_placement_group.this.arn
}

output "name" {
  description = "The name of the placement group."
  value       = aws_placement_group.this.name
}

output "strategy" {
  description = "The placement strategy."
  value       = var.strategy
}

output "partition_size" {
  description = "The number of partitions in the placement group. Only configured when the `strategy` is `PARTITION`."
  value       = aws_placement_group.this.partition_count
}

output "spread_level" {
  description = "The spread level to determine how the placement group spread instance. Only configured when the `strategy` is `SPREAD`."
  value       = try(upper(aws_placement_group.this.spread_level), null)
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
