output "id" {
  description = "The ID of the instance."
  value       = try(aws_instance.this[0].id, aws_spot_instance_request.this[0].id)
}

output "arn" {
  description = "The ARN of the instance."
  value       = try(aws_instance.this[0].arn, aws_spot_instance_request.this[0].arn)
}

output "name" {
  description = "The name of the instance."
  value       = var.name
}

# TODO: Capitalize
output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`."
  value       = try(aws_instance.this[0].instance_state, aws_spot_instance_request.this[0].instance_state)
}

output "private_domain" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC."
  value       = try(aws_instance.this[0].private_dns, aws_spot_instance_request.this[0].private_dns)
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.this[0].private_ip, aws_spot_instance_request.this[0].private_ip)
}

output "public_domain" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC."
  value       = try(aws_instance.this[0].public_dns, aws_spot_instance_request.this[0].public_dns)
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached."
  value       = try(aws_instance.this[0].public_ip, aws_spot_instance_request.this[0].public_ip)
}

output "test" {
  description = "The configuration of rule groups associated with the firewall."
  value       = try(aws_instance.this[0], aws_spot_instance_request.this[0])
}
