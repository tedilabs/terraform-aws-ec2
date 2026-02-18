output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_key_pair.this.region
}

output "id" {
  description = "The ID of the SSH key pair."
  value       = aws_key_pair.this.key_pair_id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the SSH key pair."
  value       = aws_key_pair.this.arn
}

output "name" {
  description = "The name of the SSH key pair."
  value       = aws_key_pair.this.key_name
}

output "public_key" {
  description = "The public key material."
  value       = aws_key_pair.this.public_key
}

output "fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = aws_key_pair.this.fingerprint
}

output "type" {
  description = "The type of the SSH key pair."
  value       = aws_key_pair.this.key_type
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
#     for k, v in aws_key_pair.this :
#     k => v
#     if !contains(["id", "key_name", "key_name_prefix", "arn", "key_pair_id", "fingerprint", "key_type", "public_key", "tags", "tags_all"], k)
#   }
# }
