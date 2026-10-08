# recycle-bin-rule

This module creates following resources.

- `aws_rbin_rule`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.32 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.1.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.32 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_rbin_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rbin_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the retention rule. A retention rule has no name attribute, so it is stored as the `Name` tag. | `string` | n/a | yes |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | (Required) The resource type to be retained by the retention rule. Valid values are `EBS_SNAPSHOT`, `EBS_VOLUME` and `EC2_IMAGE`. | `string` | n/a | yes |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | (Required) The number of days to retain deleted resources in the Recycle Bin. Valid values are from `1` to `365` for `EBS_SNAPSHOT` and `EC2_IMAGE`, and from `1` to `7` for `EBS_VOLUME`. | `number` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the retention rule. Defaults to `Managed by Terraform.`. | `string` | `"Managed by Terraform."` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | (Optional) The configuration to filter the resources to retain by resource tags. `filter` as defined below.<br/>    (Optional) `mode` - The mode to filter the resources. Valid values are `INCLUSION` and `EXCLUSION`. Defaults to `EXCLUSION`.<br/>      `INCLUSION` - Retain only the resources that have any of `resource_tags`.<br/>      `EXCLUSION` - Retain all resources in the Region, except the resources that have any of `resource_tags`.<br/>    (Optional) `resource_tags` - A map of resource tags to include or exclude, according to `mode`. Required at least one tag for `INCLUSION` mode. Defaults to `{}`. | <pre>object({<br/>    mode          = optional(string, "EXCLUSION")<br/>    resource_tags = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | (Optional) The configuration of the retention rule lock. A locked rule can't be modified or deleted until it is unlocked and the unlock delay expires. `lock` as defined below.<br/>    (Optional) `enabled` - Whether to lock the retention rule. Only a rule in `EXCLUSION` mode with empty `filter.resource_tags` can be locked. Defaults to `false`.<br/>    (Optional) `unlock_delay` - The number of days to wait after the rule is unlocked before it can be modified or deleted. Valid values are from `7` to `30`. Defaults to `7`. | <pre>object({<br/>    enabled      = optional(bool, false)<br/>    unlock_delay = optional(number, 7)<br/>  })</pre> | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. The data collected is anonymous and does not contain any sensitive information. The default configuration enables telemetry collection for machine, network, git, github, github actions, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the retention rule to be created/updated/deleted. | <pre>object({<br/>    create = optional(string, "30m")<br/>    update = optional(string, "30m")<br/>    delete = optional(string, "30m")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the retention rule. |
| <a name="output_description"></a> [description](#output\_description) | The description of the retention rule. |
| <a name="output_filter"></a> [filter](#output\_filter) | The configuration to filter the resources to retain by resource tags.<br/>    `mode` - The mode to filter the resources. `INCLUSION` or `EXCLUSION`.<br/>    `resource_tags` - A map of resource tags to include or exclude, according to `mode`. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the retention rule. |
| <a name="output_lock"></a> [lock](#output\_lock) | The lock configuration of the retention rule.<br/>    `enabled` - Whether the retention rule is locked.<br/>    `unlock_delay` - The number of days to wait after the rule is unlocked before it can be modified or deleted. |
| <a name="output_name"></a> [name](#output\_name) | The name of the retention rule. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_resource_type"></a> [resource\_type](#output\_resource\_type) | The resource type retained by the retention rule. |
| <a name="output_retention_period"></a> [retention\_period](#output\_retention\_period) | The number of days to retain deleted resources in the Recycle Bin. |
| <a name="output_status"></a> [status](#output\_status) | The state of the retention rule. Only retention rules in the `AVAILABLE` state retain resources. |
<!-- END_TF_DOCS -->
