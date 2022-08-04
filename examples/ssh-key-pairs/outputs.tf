output "ssh_keys" {
  value = {
    "rsa-4096" = module.rsa_4096
    "ed25519"  = module.ed25519
  }
}
