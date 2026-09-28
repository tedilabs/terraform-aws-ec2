variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the retention rule. A retention rule has no name attribute, so it is stored as the `Name` tag."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the retention rule. Defaults to `Managed by Terraform.`."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "resource_type" {
  description = "(Required) The resource type to be retained by the retention rule. Valid values are `EBS_SNAPSHOT`, `EBS_VOLUME` and `EC2_IMAGE`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["EBS_SNAPSHOT", "EBS_VOLUME", "EC2_IMAGE"], var.resource_type)
    error_message = "Valid values for `resource_type` are `EBS_SNAPSHOT`, `EBS_VOLUME` and `EC2_IMAGE`."
  }
}

variable "retention_period" {
  description = "(Required) The number of days to retain deleted resources in the Recycle Bin. Valid values are from `1` to `365` for `EBS_SNAPSHOT` and `EC2_IMAGE`, and from `1` to `7` for `EBS_VOLUME`."
  type        = number
  nullable    = false

  validation {
    condition = anytrue([
      var.resource_type == "EBS_VOLUME" && (var.retention_period >= 1 && var.retention_period <= 7),
      contains(["EBS_SNAPSHOT", "EC2_IMAGE"], var.resource_type) && (var.retention_period >= 1 && var.retention_period <= 365),
    ])
    error_message = "`retention_period` must be between 1 and 7 days for `EBS_VOLUME`, and between 1 and 365 days for `EBS_SNAPSHOT` and `EC2_IMAGE`."
  }
}

variable "resource_tags" {
  description = "(Optional) A map of resource tags to identify the resources to retain. A resource that has any of these tags is retained. If provided, the rule is a tag-level retention rule. Otherwise, the rule is a Region-level retention rule."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = length(var.resource_tags) <= 50
    error_message = "`resource_tags` can have up to 50 tags."
  }
}

variable "exclude_resource_tags" {
  description = "(Optional) A map of resource tags to exclude from a Region-level retention rule. A resource that has any of these tags is not retained. Cannot be used with `resource_tags`."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = length(var.exclude_resource_tags) <= 50
    error_message = "`exclude_resource_tags` can have up to 50 tags."
  }
  validation {
    condition     = length(var.exclude_resource_tags) == 0 || length(var.resource_tags) == 0
    error_message = "`exclude_resource_tags` can only be used with a Region-level retention rule (empty `resource_tags`)."
  }
}

variable "lock" {
  description = <<EOF
  (Optional) The configuration of the retention rule lock. A locked rule can't be modified or deleted until it is unlocked and the unlock delay expires. `lock` as defined below.
    (Optional) `enabled` - Whether to lock the retention rule. Only a Region-level retention rule without `exclude_resource_tags` can be locked. Defaults to `false`.
    (Optional) `unlock_delay` - The number of days to wait after the rule is unlocked before it can be modified or deleted. Valid values are from `7` to `30`. Defaults to `7`.
  EOF
  type = object({
    enabled      = optional(bool, false)
    unlock_delay = optional(number, 7)
  })
  default  = {}
  nullable = false

  validation {
    condition     = var.lock.unlock_delay >= 7 && var.lock.unlock_delay <= 30
    error_message = "`lock.unlock_delay` must be between 7 and 30 days."
  }
  validation {
    condition = !var.lock.enabled || (
      length(var.resource_tags) == 0 && length(var.exclude_resource_tags) == 0
    )
    error_message = "Only a Region-level retention rule without `exclude_resource_tags` can be locked."
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
