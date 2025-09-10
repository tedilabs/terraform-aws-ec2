variable "name" {
  description = "(Required) The name of the placement group."
  type        = string
}

variable "strategy" {
  description = <<EOF
  (Required) The placement strategy of the placement group. Valid values are `CLUSTER`, `PARTITION` or `SPREAD`.
    `CLUSTER` - packs instances close together inside an Availability Zone. This strategy enables workloads to achieve the low-latency network performance necessary for tightly-coupled node-to-node communication that is typical of HPC applications.
    `PARTITION` - spreads your instances across logical partitions such that groups of instances in one partition do not share the underlying hardware with groups of instances in different partitions. This strategy is typically used by large distributed and replicated workloads, such as Hadoop, Cassandra, and Kafka.
    `SPREAD` - strictly places a small group of instances across distinct underlying hardware to reduce correlated failures.
  EOF
  type        = string
  nullable    = false

  validation {
    condition     = contains(["CLUSTER", "PARTITION", "SPREAD"], var.strategy)
    error_message = "Valid values are `CLUSTER`, `PARTITION` or `SPREAD`."
  }
}

variable "partition_size" {
  description = "(Optional) The number of partitions to create in the placement group. Can only be specified when the `strategy` is set to `PARTITION`. Valid values are 1 - 7. Defaults to `2`."
  type        = number
  default     = 2
  nullable    = false
}

variable "spread_level" {
  description = "(Optional) The spread level to determine how the placement group spread instances. Can only be specified when the `strategy` is set to `SPREAD`. Valid values are `HOST` and `RACK`. `HOST` can only be used for Outpost placement groups."
  type        = string
  default     = "RACK"
  nullable    = false

  validation {
    condition     = contains(["HOST", "RACK"], var.spread_level)
    error_message = "Valid values are `HOST`, or `RACK`."
  }
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




variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
