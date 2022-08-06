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
# - `private_ip`
# - `secondary_private_ips`
# - `network_interface`
# - `associate_public_ip_address`
#
# - `ephemeral_block_device`
# - `root_block_device`
# - `ebs_block_device`
# - `ebs_block_optimized`
#
# - `capacity_reservation_specification`
# - `enclave_options`
# - `get_password_data`
# - `hibernation`
# - `launch_template`
# - `metadata_options`
#
# - `volume_tags`
resource "aws_instance" "this" {
  count = var.spot_enabled ? 0 : 1

  instance_type        = var.type
  ami                  = var.ami
  key_name             = var.ssh_key
  iam_instance_profile = var.instance_profile


  ## Network Configuration
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  # vpc_security_group_ids = [aws_security_group.web.id]
  source_dest_check = var.source_dest_check_enabled


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


  ## Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  maintenance_options {
    auto_recovery = try(var.auto_recovery_enabled ? "default" : "disabled", null)
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
}

resource "aws_spot_instance_request" "this" {
  count = var.spot_enabled ? 1 : 0

  instance_type        = var.type
  ami                  = var.ami
  key_name             = var.ssh_key
  iam_instance_profile = var.instance_profile


  ## Network Configuration
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  # vpc_security_group_ids = [aws_security_group.web.id]
  source_dest_check = var.source_dest_check_enabled


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


  ## Attributes
  instance_initiated_shutdown_behavior = try(lower(var.shutdown_behavior), null)
  disable_api_stop                     = var.stop_protection_enabled
  disable_api_termination              = var.termination_protection_enabled
  monitoring                           = var.monitoring_enabled

  maintenance_options {
    auto_recovery = try(var.auto_recovery_enabled ? "default" : "disabled", null)
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
}
