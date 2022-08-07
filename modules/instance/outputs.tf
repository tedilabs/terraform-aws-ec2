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

output "type" {
  description = "The instance type to use for the instance."
  value       = try(aws_instance.this[0].instance_type, aws_spot_instance_request.this[0].instance_type)
}

output "ami" {
  description = "The AMI to run on the instance."
  value       = try(aws_instance.this[0].ami, aws_spot_instance_request.this[0].ami)
}

output "ssh_key" {
  description = "The name of the SSH Key to access the instance."
  value       = try(aws_instance.this[0].key_name, aws_spot_instance_request.this[0].key_name)
}

output "instance_profile" {
  description = "The IAM Instance Profile of the instance."
  value       = try(aws_instance.this[0].iam_instance_profile, aws_spot_instance_request.this[0].iam_instance_profile)
}

output "private_domain" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC."
  value       = try(aws_instance.this[0].private_dns, aws_spot_instance_request.this[0].private_dns)
}

output "public_domain" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC."
  value       = try(aws_instance.this[0].public_dns, aws_spot_instance_request.this[0].public_dns)
}

output "network" {
  description = <<EOF
  The network configuration for the instance.
    `availability_zone` - The Availability Zone of the instance.
    `subnet_id` - The ID of subnet of the launched instance.
    `source_dest_check_enabled` - Whether the traffic is routed to the instance when the destination address does not match the instance.
    `public_ip` - The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached.
    `private_ip` - The private IP address assigned to the instance.
    `secondary_private_ips` - A list of secondary private IPv4 addresses assigned to the instance's primary network interface.
  EOF
  value = {
    availability_zone         = try(aws_instance.this[0].availability_zone, aws_spot_instance_request.this[0].availability_zone)
    subnet_id                 = try(aws_instance.this[0].subnet_id, aws_spot_instance_request.this[0].subnet_id)
    security_groups           = try(aws_instance.this[0].vpc_security_group_ids, aws_spot_instance_request.this[0].vpc_security_group_ids)
    source_dest_check_enabled = try(aws_instance.this[0].source_dest_check, aws_spot_instance_request.this[0].source_dest_check)

    auto_assign_public_ip_enabled = try(aws_instance.this[0].associate_public_ip_address, aws_spot_instance_request.this[0].associate_public_ip_address)
    public_ip                     = try(aws_instance.this[0].public_ip, aws_spot_instance_request.this[0].private_ip)
    private_ip                    = try(aws_instance.this[0].private_ip, aws_spot_instance_request.this[0].private_ip)
    secondary_private_ips         = try(aws_instance.this[0].secondary_private_ips, aws_spot_instance_request.this[0].secondary_private_ips)
    eip_associations = {
      for id, association in aws_eip_association.this :
      association.public_ip => {
        id = id

        network_interface = association.network_interface_id
        private_ip        = association.private_ip_address
      }
    }
  }
}

output "metadata" {
  description = <<EOF
  The configuration for metadata of the instance.
  EOF
  value = {
    http = {
      enabled                = try(aws_instance.this[0].metadata_options[0].http_endpoint, aws_spot_instance_request.this[0].metadata_options[0].http_endpoint) == "enabled"
      token_required         = try(aws_instance.this[0].metadata_options[0].http_tokens, aws_spot_instance_request.this[0].metadata_options[0].http_tokens) == "required"
      put_response_hop_limit = try(aws_instance.this[0].metadata_options[0].http_put_response_hop_limit, aws_spot_instance_request.this[0].metadata_options[0].http_put_response_hop_limit)
    }
    instance_tags = {
      enabled = try(aws_instance.this[0].metadata_options[0].instance_metadata_tags, aws_spot_instance_request.this[0].metadata_options[0].instance_metadata_tags) == "enabled"
    }
  }
}

output "cpu" {
  description = <<EOF
  The CPU configuration for the instance.
    `options` - The CPU options for the instance.
    `credit_specification` - The CPU credit specification for the instance.
  EOF
  value = {
    options = {
      core_count       = try(aws_instance.this[0].cpu_core_count, aws_spot_instance_request.this[0].cpu_core_count)
      threads_per_core = try(aws_instance.this[0].cpu_threads_per_core, aws_spot_instance_request.this[0].cpu_threads_per_core)
    }
    credit_specification = try(upper(aws_instance.this[0].credit_specification[0].cpu_credits), upper(aws_spot_instance_request.this[0].credit_specification[0].cpu_credits), null)
  }
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

output "storage" {
  description = "The configuration of storage for the instance."
  value = {
    ebs = {
      optimized = try(aws_instance.this[0].ebs_optimized, aws_spot_instance_request.this[0].ebs_optimized)
    }
  }
}

output "attributes" {
  description = "A set of attributes that applied to the instance."
  value = {
    shutdown_behavior              = try(upper(aws_instance.this[0].instance_initiated_shutdown_behavior), upper(aws_spot_instance_request.this[0].instance_initiated_shutdown_behavior))
    stop_hibernation_enabled       = try(aws_instance.this[0].hibernation, aws_spot_instance_request.this[0].hibernation)
    stop_protection_enabled        = try(aws_instance.this[0].disable_api_stop, aws_spot_instance_request.this[0].disable_api_stop)
    termination_protection_enabled = try(aws_instance.this[0].disable_api_termination, aws_spot_instance_request.this[0].disable_api_termination)
    auto_recovery_enabled          = try(upper(aws_instance.this[0].maintenance_options[0].auto_recovery), upper(aws_spot_instance_request.this[0].maintenance_options[0].auto_recovery)) == "DEFAULT"
    nitro_enclave_enabled          = try(aws_instance.this[0].enclave_options[0].enabled, aws_spot_instance_request.this[0].enclave_options[0].enabled)
    monitoring_enabled             = try(aws_instance.this[0].monitoring, aws_spot_instance_request.this[0].monitoring)
  }
}

output "test" {
  description = "The configuration of rule groups associated with the firewall."
  value = {
    for k, v in try(aws_instance.this[0], aws_spot_instance_request.this[0]) :
    k => v
    if !contains(["arn", "id", "availability_zone", "disable_api_stop", "disable_api_termination", "instance_state", "private_ip", "private_dns", "public_ip", "public_dns", "tags", "tags_all", "security_grouops", "cpu_core_count", "cpu_threads_per_core", "subnet_id", "timeouts", "credit_specification", "monitoring", "instance_initiated_shutdown_behavior", "maintenance_options", "placement_group", "placement_partition_number", "host_id", "tenancy", "key_name", "instance_type", "ami", "source_dest_check", "iam_instance_profile", "associate_public_ip_address", "ebs_optimized", "secondary_private_ips", "security_groups", "vpc_security_group_ids", "hibernation", "volume_tags", "enclave_options", "metadata_options"], k)
  }

}
