variable "name" {
  description = "(Required) The name of the instance."
  type        = string
  nullable    = false
}

variable "type" {
  description = "(Optional) The instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."
  type        = string
  default     = null
}

variable "ami" {
  description = "(Optional) The AMI to run on the instance."
  type        = string
  default     = null
}

variable "ssh_key" {
  description = "(Optional) The name of the SSH Key that should be used to access the instance."
  type        = string
  default     = null
}

variable "instance_profile" {
  description = "(Optional) The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. Ensure your credentials have the correct permission to assign the instance profile according to the EC2 documentation, notably `iam:PassRole`."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "(Optional) AZ (Availability Zone) to create the instance in."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(Optional) The ID of subnet in which to launch the instance."
  type        = string
  default     = null
}

variable "security_groups" {
  description = "(Optional) A set of security group IDs to assign to the instance."
  type        = set(string)
  default     = []
}

variable "source_dest_check_enabled" {
  description = "(Optional) Whether the traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults to `true`."
  type        = bool
  default     = null
}

variable "auto_assign_public_ip_enabled" {
  description = "(Optional) Whether a public IP address is automatically assigned to the primary network interface of the instance in a VPC."
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "(Optional) The primary private IPv4 address to associate with the instance."
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "(Optional) A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0). Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e., referenced in a network_interface block."
  type        = set(string)
  default     = null
}

variable "eip_associations" {
  description = <<EOF
  (Optional) A list of configurations to associate Elastic IPs to the network interfaces of the instance. Each `eip_associations` block as defined below.
    (Required) `eip` - The allocation ID of Elastic IP to associate.
    (Optional) `private_ip` - The primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address.
  EOF
  type        = list(map(string))
  default     = []
  nullable    = false
}

variable "hostname_type" {
  description = "(Optional) The type of hostname for the EC2 instances. For IPv4 only subnets, an instance DNS name must be based on the instance IPv4 address. For IPv6 native subnets, an instance DNS name must be based on the instance ID. For dual-stack subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID. Valid values are `IP_V4` and `RESOURCE_NAME`."
  type        = string
  default     = null
}

variable "dns_resource_name_ipv4_enabled" {
  description = "(Optional) Whether to resolve the IPv4 address of the EC2 instance for requests to your resource-name based domain."
  type        = bool
  default     = null
}

variable "dns_resource_name_ipv6_enabled" {
  description = "(Optional) Whether to resolve the IPv6 address of the EC2 instance for requests to your resource-name based domain."
  type        = bool
  default     = null
}

variable "metadata_options" {
  description = <<EOF
  (Optional) The configuration for metadata of the instance. `metadata_options` block as defined below.
    (Optional) `http_enabled` - Whether the metadata service is available. You can turn off access to your instance metadata by disabling the HTTP endpoint of the instance metadata service. Defaults to `true`.
    (Optional) `http_token_required` - Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Defaults to `false`.
    (Optional) `http_put_response_hop_limit` - A desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values are integer from `1` to `64`. Defaults to `1`.
    (Optional) `instance_tags_enabled` - Whether to enable the access to instance tags from the instance metadata service. Defaults to `false`.
  EOF
  type        = any
  default     = null
}

# INFO: This option is only supported on creation of instance type that support CPU Options
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html#cpu-options-supported-instances-values
variable "cpu_options" {
  description = <<EOF
  (Optional) The configuration of the CPU options to optimize the instance for specific workloads or business needs. You can specify these CPU options during instance launch. There is no additional or reduced charge for specifying CPU options. `cpu_options` block as defined below.
    (Optional) `core_count` - Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API.
    (Optional) `threads_per_core` - Set the number of CPU threads per core for the instance. If set to to 1, hyperthreading is disabled on the launched instance.
  EOF
  type = object({
    core_count       = number
    threads_per_core = number
  })
  default = null
}

variable "cpu_credit_specification" {
  description = "(Optional) The specification for CPU credit. A credit specification is only available for T2, T3, and T3a instances. Valid values are `STANDARD` or `UNLIMITED`. T3 instances are launched as `UNLIMITED` by default. T2 instances are launched as `STANDARD` by default."
  type        = string
  default     = null
}

variable "host_id" {
  description = "(Optional) The ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
  type        = string
  default     = null
}

variable "tenancy" {
  description = "(Optional) The tenancy of the instance (if the instance is running in a VPC). Valid values are `DEFAULT`, `DEDICATED` or `HOST`."
  type        = string
  default     = null
}

variable "placement_group" {
  description = "(Optional) The name of the placement group to start the instance in, if applicable. Choose an instance type that supports enhanced networking to use `CLUSTER` placement group. You cannot launch Dedicated Hosts in placement groups."
  type        = string
  default     = null
}

variable "placement_group_partition" {
  description = "(Optional) The index of the partition the instance is in. Valid only if the `placement_group` resource's strategy is set to `PARTITION`."
  type        = number
  default     = null
}

variable "ebs_optimized" {
  description = "(Optional) Whether to enable additional, dedicated throughput between Amazon EC2 and Amazon EBS. The launched EC2 instance will be EBS-optimized if true. Note that if this is not set on an instance type that is optimized by default then this will show as disabled but if the instance type is optimized by default then there is no need to set this and there is no effect to disabling it."
  type        = bool
  default     = null
}

variable "root_block_device" {
  description = <<EOF
  (Optional) The configuration for root block device of the instance. `root_block_device` block as defined below.
    (Optional) `type` - The type of volume to attach.
    (Optional) `size` - The size of the volume, in GiB. If you are creating the volume from a snapshot, then the size of the volume can’t be smaller than the size of the snapshot.
    (Optional) `provisioned_iops` - The amount of provisioned IOPS. Only valid for type of `io1`, `io2` or `gp3`.
    (Optional) `provisioned_throughput` - Throughput to provision for a volume in mebibytes per second (MiB/s). This is only valid for type of `gp3`.
    (Optional) `encryption_enabled` - Whether to enable volume encryption. Defaults to `false`.
    (Optional) `encryption_kms_key` - The ARN(Amazon Resource Name) of the KMS Key to use when encrypting the volume.
    (Optional) `delete_on_termination` - Whether the volume should be destroyed on instance termination. Defaults to `true`.
    (Optional) `tags` - A map of tags to assign to the device.
  EOF
  type        = any
  default     = {}
  nullable    = false
}

variable "shutdown_behavior" {
  description = "(Optional) The instance behavior when an OS-level shutdown is performed. Instances can be either terminated or stopped. Valid values are `STOP` or `TERMINATE`. Amazon defaults this to `STOP` for EBS-backed instances and `TERMINATE` for instance-store instances. Cannot be set on instance-store instances."
  type        = string
  default     = null
}

variable "stop_hibernation_enabled" {
  description = "(Optional) Indicates whether to support hibernation stop for the instance. Hibernation stops your instance and saves the contents of the instance’s RAM to the root volume. You cannot enable hibernation after launch."
  type        = bool
  default     = null
}

variable "stop_protection_enabled" {
  description = "(Optional) Indicates whether stop of the instance via the AWS API will be protected. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "termination_protection_enabled" {
  description = "(Optional) Indicates whether termination of the instance via the AWS API will be protected. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "auto_recovery_enabled" {
  description = "(Optional) Whether to enable auto-recovery for the instance. Instance auto-recovery recovers your instance if system status checks fail. By default, shared tenancy without local storage and GPUs are set to auto-recover."
  type        = bool
  default     = null
}

variable "nitro_enclave_enabled" {
  description = "(Optional) Whether to enable Nitro Enclaves on the instance. A Nitro Enclave is a trusted execution environment (TEE) in which you can securely process sensitive data. It extends the security and isolation characteristics of the AWS Nitro System and allows you to create isolated compute environments within Amazon EC2 instances. Defaults to `false`."
  type        = bool
  default     = null
}

variable "monitoring_enabled" {
  description = "(Optional) If true, the launched EC2 instance will have detailed monitoring enabled."
  type        = bool
  default     = null
}

variable "launch_template" {
  description = <<EOF
  (Optional) The configuration for launch template of the instance. Launch Template parameters will be used only once during instance creation. If you want to update existing instance you need to change parameters directly. Updating Launch Template specification will force a new instance. Any other instance parameters that you specify will override the same parameters in the launch template. `launch_template` block as defined below.
    (Optional) `id` - The ID of the launch template. Conflicts with `name`.
    (Optional) `name` - The name of the launch template. Conflicts with `id`.
    (Optional) `version` - The version of launch template. Valid value is a specific version number, `$Latest` or `$Default`. Defaults to `$Default`.
  EOF
  type        = map(string)
  default     = null
}

variable "spot_enabled" {
  description = "(Optional) Whether to create the instance as a spot instance."
  type        = bool
  default     = false
  nullable    = false
}

variable "ami_snapshots" {
  description = "(Optional) A list of names for AMI snapshots of the instance. Each name should be a region-unique name for the AMI."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "ami_snapshots_without_reboot_enabled" {
  description = "(Optional) Whether to overrides the behavior of stopping the instance before snapshotting. This is risky since it may cause a snapshot of an inconsistent filesystem state, but can be used to avoid downtime if the user otherwise guarantees that no filesystem writes will be underway at the time of snapshot."
  type        = bool
  default     = true
  nullable    = false
}

variable "timeouts" {
  description = "(Optional) How long to wait for the instance to be created/updated/deleted."
  type        = map(string)
  default = {
    create = "10m"
    update = "10m"
    delete = "20m"
  }
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
