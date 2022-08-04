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

output "fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = aws_key_pair.this.fingerprint
}

output "type" {
  description = "The type of the SSH key pair."
  value       = aws_key_pair.this.key_type
}
