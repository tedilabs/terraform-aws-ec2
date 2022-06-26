variable "name" {
  description = "(Required) The name of the placement group."
  type        = string
}

variable "strategy" {
  description = "(Required) The placement strategy of the placement group."
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

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
