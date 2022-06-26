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

output "availability_zone" {
  description = "The Availability Zone of the instance."
  value       = try(aws_instance.this[0].availability_zone, aws_spot_instance_request.this[0].availability_zone)
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

output "attributes" {
  description = "A set of attributes that applied to the instance."
  value = {
    stop_protection_enabled        = try(aws_instance.this[0].disable_api_stop, aws_spot_instance_request.this[0].disable_api_stop)
    termination_protection_enabled = try(aws_instance.this[0].disable_api_termination, aws_spot_instance_request.this[0].disable_api_termination)
  }
}

output "test" {
  description = "The configuration of rule groups associated with the firewall."
  value = {
    for k, v in try(aws_instance.this[0], aws_spot_instance_request.this[0]) :
    k => v
    if !contains(["arn", "id", "availability_zone", "disable_api_stop", "disable_api_termination", "instance_state", "private_ip", "private_dns", "public_ip", "public_dns", "tags", "tags_all", "security_grouops"], k)
  }

}
