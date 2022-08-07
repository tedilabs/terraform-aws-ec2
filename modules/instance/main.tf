locals {
  metadata = {
    package = "terraform-aws-ec2"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  is_t_type = replace(var.type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
}


###################################################
# EC2 Instance
###################################################

# INFO: Not supported attributes
# - `security_groups`
#
# - `user_data`
# - `user_data_base64`
# - `user_data_replace_on_change`
#
# - `ipv6_address_count`
# - `ipv6_addresses`
# - `private_dns_name_options`
# - `network_interface`
#
# - `ephemeral_block_device`
# - `root_block_device`
# - `ebs_block_device`
#
# - `capacity_reservation_specification`
# - `get_password_data`
# - `launch_template`
# TODO: hibernation enabled with root device encryption
resource "aws_instance" "this" {
  count = var.spot_enabled ? 0 : 1

  instance_type        = var.type
  ami                  = var.ami
  key_name             = var.ssh_key
  iam_instance_profile = var.instance_profile


  ## Network Configuration
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  source_dest_check      = var.source_dest_check_enabled

  associate_public_ip_address = var.auto_assign_public_ip_enabled
  private_ip                  = var.private_ip
  secondary_private_ips       = var.secondary_private_ips


  ## Metadata
  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    iterator = metadata

    content {
      http_endpoint               = try(metadata.value.http_enabled, true) ? "enabled" : "disabled"
      http_tokens                 = try(metadata.value.http_token_required, false) ? "required" : "optional"
      http_put_response_hop_limit = try(metadata.value.http_put_response_hop_limit, 1)

      instance_metadata_tags = try(metadata.value.instance_tags_enabled, false) ? "enabled" : "disabled"
    }
  }


  ## CPU
  cpu_core_count       = try(var.cpu_options.core_count, null)
  cpu_threads_per_core = try(var.cpu_options.threads_per_core, null)

  credit_specification {
    cpu_credits = (local.is_t_type
      ? lower(var.cpu_credit_specification)
      : null
    )
  }


  ## Host & Placement Group
  host_id                    = var.host_id
  tenancy                    = try(lower(var.tenancy), null)
  placement_group            = var.placement_group
  placement_partition_number = var.placement_group_partition


  ## Storage
  ebs_optimized = var.ebs_optimized


  ## Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  hibernation                          = var.stop_hibernation_enabled
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  maintenance_options {
    auto_recovery = try(var.auto_recovery_enabled ? "default" : "disabled", null)
  }

  enclave_options {
    enabled = var.nitro_enclave_enabled
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
  volume_tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

# INFO: Not supported attributes
# - `security_groups`
resource "aws_spot_instance_request" "this" {
  count = var.spot_enabled ? 1 : 0

  instance_type        = var.type
  ami                  = var.ami
  key_name             = var.ssh_key
  iam_instance_profile = var.instance_profile


  ## Network Configuration
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  source_dest_check      = var.source_dest_check_enabled

  associate_public_ip_address = var.auto_assign_public_ip_enabled
  private_ip                  = var.private_ip
  secondary_private_ips       = var.secondary_private_ips


  ## Metadata
  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    iterator = metadata

    content {
      http_endpoint               = try(metadata.value.http_enabled, true) ? "enabled" : "disabled"
      http_tokens                 = try(metadata.value.http_token_required, false) ? "required" : "optional"
      http_put_response_hop_limit = try(metadata.value.http_put_response_hop_limit, 1)

      instance_metadata_tags = try(metadata.value.instance_tags_enabled, false) ? "enabled" : "disabled"
    }
  }


  ## CPU
  cpu_core_count       = try(var.cpu_options.core_count, null)
  cpu_threads_per_core = try(var.cpu_options.threads_per_core, null)

  credit_specification {
    cpu_credits = (local.is_t_type
      ? lower(var.cpu_credit_specification)
      : null
    )
  }


  ## Host & Placement Group
  host_id                    = var.host_id
  tenancy                    = try(lower(var.tenancy), null)
  placement_group            = var.placement_group
  placement_partition_number = var.placement_group_partition


  ## Storage
  ebs_optimized = var.ebs_optimized


  ## Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  hibernation                          = var.stop_hibernation_enabled
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  maintenance_options {
    auto_recovery = try(var.auto_recovery_enabled ? "default" : "disabled", null)
  }

  enclave_options {
    enabled = var.nitro_enclave_enabled
  }

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
  volume_tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
