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

variable "subnet_id" {
  description = "(Optional) The ID of subnet in which to launch the instance."
  type        = string
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

variable "spot_enabled" {
  description = "(Optional) Whether to create the instance as a spot instance."
  type        = bool
  default     = false
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
