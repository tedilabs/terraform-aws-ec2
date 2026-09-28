output "rules" {
  value = {
    "image"    = module.image
    "snapshot" = module.snapshot
    "volume"   = module.volume
  }
}
