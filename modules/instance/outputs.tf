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
output "state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`."
  value       = try(aws_instance.this[0].instance_state, aws_spot_instance_request.this[0].instance_state)
}

output "availability_zone" {
  description = "The Availability Zone of the instance."
  value       = try(aws_instance.this[0].availability_zone, aws_spot_instance_request.this[0].availability_zone)
}

output "subnet_id" {
  description = "The ID of subnet of the launched instance."
  value       = try(aws_instance.this[0].subnet_id, aws_spot_instance_request.this[0].subnet_id)
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

output "cpu_options" {
  description = "The CPU options for the instance."
  value = {
    core_count = try(aws_instance.this[0].cpu_core_count,
    aws_spot_instance_request.this[0].cpu_core_count)
    threads_per_core = try(aws_instance.this[0].cpu_threads_per_core, aws_spot_instance_request.this[0].cpu_threads_per_core)
  }
}

output "cpu_credit_specification" {
  description = "The CPU credit specification for the instance."
  value       = try(upper(aws_instance.this[0].credit_specification[0].cpu_credits), upper(aws_spot_instance_request.this[0].credit_specification[0].cpu_credits), null)
}

output "host" {
  description = "The configuration of host and placement group for the instance."
  value = {
    id      = try(aws_instance.this[0].host_id, aws_spot_instance_request.this[0].host_id)
    tenancy = try(upper(aws_instance.this[0].tenancy), upper(aws_spot_instance_request.this[0].tenancy))
    placement_group = try(
      {
        name      = aws_instance.this[0].placement_group
        partition = aws_instance.this[0].placement_partition_number
      },
      {
        name      = aws_spot_instance_request.this[0].placement_group
        partition = aws_spot_instance_request.this[0].placement_partition_number
      },
      null
    )
  }
}

output "attributes" {
  description = "A set of attributes that applied to the instance."
  value = {
    shutdown_behavior              = try(upper(aws_instance.this[0].instance_initiated_shutdown_behavior), upper(aws_spot_instance_request.this[0].instance_initiated_shutdown_behavior))
    stop_protection_enabled        = try(aws_instance.this[0].disable_api_stop, aws_spot_instance_request.this[0].disable_api_stop)
    termination_protection_enabled = try(aws_instance.this[0].disable_api_termination, aws_spot_instance_request.this[0].disable_api_termination)
    auto_recovery_enabled          = try(upper(aws_instance.this[0].maintenance_options[0].auto_recovery), upper(aws_spot_instance_request.this[0].maintenance_options[0].auto_recovery)) == "DEFAULT"
    monitoring_enabled             = try(aws_instance.this[0].monitoring, aws_spot_instance_request.this[0].monitoring)
  }
}

output "test" {
  description = "The configuration of rule groups associated with the firewall."
  value = {
    for k, v in try(aws_instance.this[0], aws_spot_instance_request.this[0]) :
    k => v
    if !contains(["arn", "id", "availability_zone", "disable_api_stop", "disable_api_termination", "instance_state", "private_ip", "private_dns", "public_ip", "public_dns", "tags", "tags_all", "security_grouops", "cpu_core_count", "cpu_threads_per_core", "subnet_id", "timeouts", "credit_specification", "monitoring", "instance_initiated_shutdown_behavior", "maintenance_options", "placement_group", "placement_partition_number", "host_id", "tenancy"], k)
  }

}
