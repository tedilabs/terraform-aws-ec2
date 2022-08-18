locals {
  instance = try(aws_instance.this[0], aws_spot_instance_request.this[0])
}

# TODO: check for spot instance id
output "id" {
  description = "The ID of the instance."
  value       = local.instance.id
}

output "arn" {
  description = "The ARN of the instance."
  value       = local.instance.arn
}

output "name" {
  description = "The name of the instance."
  value       = var.name
}

# TODO: Capitalize
output "state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`."
  value       = local.instance.instance_state
}

output "type" {
  description = "The instance type to use for the instance."
  value       = local.instance.instance_type
}

output "ami" {
  description = "The AMI to run on the instance."
  value       = local.instance.ami
}

output "ssh_key" {
  description = "The name of the SSH Key to access the instance."
  value       = local.instance.key_name
}

output "instance_profile" {
  description = "The IAM Instance Profile of the instance."
  value       = local.instance.iam_instance_profile
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

    `public_domain` - The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC.
    `private_domain` - The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC.
    `hostname_type` - The type of hostname for the EC2 instances.
    `dns_resource_name_ipv4_enabled` - Whether to resolve the IPv4 address of the EC2 instance for requests to your resource-name based domain.
    `dns_resource_name_ipv6_enabled` - Whether to resolve the IPv6 address of the EC2 instance for requests to your resource-name based domain.
  EOF
  value = {
    availability_zone         = local.instance.availability_zone
    subnet_id                 = local.instance.subnet_id
    security_groups           = local.instance.vpc_security_group_ids
    source_dest_check_enabled = local.instance.source_dest_check

    primary_network_interface_id  = local.instance.primary_network_interface_id
    auto_assign_public_ip_enabled = local.instance.associate_public_ip_address
    public_ip                     = local.instance.public_ip
    private_ip                    = local.instance.private_ip
    secondary_private_ips         = local.instance.secondary_private_ips
    eip_associations = {
      for id, association in aws_eip_association.this :
      association.public_ip => {
        id = id

        network_interface = association.network_interface_id
        private_ip        = association.private_ip_address
      }
    }

    public_domain  = local.instance.public_dns
    private_domain = local.instance.private_dns
    hostname_type = {
      for k, v in local.hostname_type :
      v => k
    }[local.instance.private_dns_name_options[0].hostname_type]
    dns_resource_name_ipv4_enabled = local.instance.private_dns_name_options[0].enable_resource_name_dns_a_record
    dns_resource_name_ipv6_enabled = local.instance.private_dns_name_options[0].enable_resource_name_dns_aaaa_record
  }
}

output "metadata" {
  description = <<EOF
  The configuration for metadata of the instance.
  EOF
  value = {
    http = {
      enabled                = local.instance.metadata_options[0].http_endpoint == "enabled"
      token_required         = local.instance.metadata_options[0].http_tokens == "required"
      put_response_hop_limit = local.instance.metadata_options[0].http_put_response_hop_limit
    }
    instance_tags = {
      enabled = local.instance.metadata_options[0].instance_metadata_tags == "enabled"
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
      core_count       = local.instance.cpu_core_count
      threads_per_core = local.instance.cpu_threads_per_core
    }
    credit_specification = try(upper(local.instance.credit_specification[0].cpu_credits), null)
  }
}

output "host" {
  description = "The configuration of host and placement group for the instance."
  value = {
    id      = local.instance.host_id
    tenancy = upper(local.instance.tenancy)
    placement_group = try(
      {
        name      = local.instance.placement_group
        partition = local.instance.placement_partition_number
      },
      null
    )
  }
}

output "storage" {
  description = "The configuration of storage for the instance."
  value = {
    ebs_optimized = local.instance.ebs_optimized

    root_block_device = {
      id          = local.instance.root_block_device[0].volume_id
      device_name = local.instance.root_block_device[0].device_name
      type        = local.instance.root_block_device[0].volume_type
      size        = local.instance.root_block_device[0].volume_size

      provisioned_iops       = local.instance.root_block_device[0].iops
      provisioned_throughput = local.instance.root_block_device[0].throughput

      encryption = {
        enabled = local.instance.root_block_device[0].encrypted
        kms_key = local.instance.root_block_device[0].kms_key_id
      }
      delete_on_termination = local.instance.root_block_device[0].delete_on_termination
    }
  }
}

output "attributes" {
  description = "A set of attributes that applied to the instance."
  value = {
    shutdown_behavior              = upper(local.instance.instance_initiated_shutdown_behavior)
    stop_hibernation_enabled       = local.instance.hibernation
    stop_protection_enabled        = local.instance.disable_api_stop
    termination_protection_enabled = local.instance.disable_api_termination
    auto_recovery_enabled          = upper(local.instance.maintenance_options[0].auto_recovery) == "DEFAULT"
    nitro_enclave_enabled          = local.instance.enclave_options[0].enabled
    monitoring_enabled             = local.instance.monitoring
  }
}

output "launch_template" {
  description = <<EOF
  The configuration for launch template of the instance.
  EOF
  value = (var.launch_template != null
    ? {
      id   = local.instance.launch_template[0].id
      name = local.instance.launch_template[0].name

      version = local.instance.launch_template[0].version
    }
    : null
  )
}

output "ami_snapshots" {
  description = "The configuration of AMI snapshots for the instance."
  value = {
    snapshots              = keys(aws_ami_from_instance.this)
    without_reboot_enabled = var.ami_snapshots_without_reboot_enabled
  }
}

output "zzz" {
  description = "The configuration of rule groups associated with the firewall."
  value = {
    for k, v in try(aws_instance.this[0], aws_spot_instance_request.this[0]) :
    k => v
    if !contains(["arn", "id", "availability_zone", "disable_api_stop", "disable_api_termination", "instance_state", "private_ip", "private_dns", "public_ip", "public_dns", "tags", "tags_all", "security_grouops", "cpu_core_count", "cpu_threads_per_core", "subnet_id", "timeouts", "credit_specification", "monitoring", "instance_initiated_shutdown_behavior", "maintenance_options", "placement_group", "placement_partition_number", "host_id", "tenancy", "key_name", "instance_type", "ami", "source_dest_check", "iam_instance_profile", "associate_public_ip_address", "ebs_optimized", "secondary_private_ips", "security_groups", "vpc_security_group_ids", "hibernation", "volume_tags", "enclave_options", "metadata_options", "launch_template", "private_dns_name_options", "root_block_device", "primary_network_interface_id"], k)
  }
}
