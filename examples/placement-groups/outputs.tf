output "placement_groups" {
  value = {
    cluster   = module.cluster
    partition = module.partition
    spread    = module.spread
  }
}
