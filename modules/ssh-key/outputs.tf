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

# output "debug" {
#   value = {
#     for k, v in aws_key_pair.this :
#     k => v
#     if !contains(["id", "key_name", "key_name_prefix", "arn", "key_pair_id", "fingerprint", "key_type", "public_key", "tags", "tags_all"], k)
#   }
# }
