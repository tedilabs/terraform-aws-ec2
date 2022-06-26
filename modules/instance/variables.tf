variable "name" {
  description = "(Required) The name of the instance."
  type        = string
}

variable "instance_ami" {
  description = "(Optional) The AMI to run on the instance."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "(Optional) The type of the instance."
  type        = string
  default     = null
}

variable "instance_ssh_key" {
  description = "(Optional) The name of the SSH Key that should be used to access the instance."
  type        = string
  default     = null
}

# variable "vpc_id" {
#   description = "(Required) The ID of the VPC which the firewall belongs to."
#   type        = string
# }
#

variable "availability_zone" {
  description = "(Optional) AZ (Availability Zone) to create the instance in."
  type        = string
  default     = null
}

variable "stop_protection_enabled" {
  description = "(Optional) Indicates whether stop of the instance via the AWS API will be protected. Defaults to `false`."
  type        = bool
  default     = false
}

variable "termination_protection_enabled" {
  description = "(Optional) Indicates whether termination of the instance via the AWS API will be protected. Defaults to `false`."
  type        = bool
  default     = false
}

variable "spot_enabled" {
  description = "(Optional) Whether to create the instance as a spot instance."
  type        = bool
  default     = false
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
