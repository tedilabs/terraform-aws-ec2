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


###################################################
# EC2 Instance
###################################################

# INFO: Not supported attributes
# - `security_groups`
#
# - `iam_instance_profile`
# - `instance_initiated_shutdown_behavior`
#
# - `source_dest_check`
# - `subnet_id`
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
# - `cpu_core_count`
# - `cpu_threads_per_core`
# - `credit_specification`
# - `enclave_options`
# - `get_password_data`
# - `hibernation`
# - `launch_template`
# - `maintenance_options`
# - `metadata_options`
# - `monitoring`
#
# - `host_id`
# - `placement_group`
# - `placement_partition_number`
# - `tenancy`
#
# - `user_data`
# - `user_data_base64`
# - `user_data_replace_on_change`
#
# - `volume_tags`
# - `timeouts`
resource "aws_instance" "this" {
  count = var.spot_enabled ? 0 : 1

  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.instance_ssh_key


  ## Network Configuration
  availability_zone = var.availability_zone
  # subnet_id     = tolist(data.aws_subnet_ids.my-subnets.ids)[0]
  # vpc_security_group_ids = [aws_security_group.web.id]


  ## Attributes
  disable_api_stop        = var.stop_protection_enabled
  disable_api_termination = var.termination_protection_enabled

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

  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.instance_ssh_key


  ## Network Configuration
  availability_zone = var.availability_zone
  # subnet_id     = tolist(data.aws_subnet_ids.my-subnets.ids)[0]
  # vpc_security_group_ids = [aws_security_group.web.id]


  ## Attributes
  disable_api_stop        = var.stop_protection_enabled
  disable_api_termination = var.termination_protection_enabled

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
