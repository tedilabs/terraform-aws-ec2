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
  value       = upper(aws_placement_group.this.spread_level)
}
