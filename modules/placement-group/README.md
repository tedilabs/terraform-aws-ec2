# placement-group

This module creates following resources.

- `aws_placement_group`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_placement_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the placement group. | `string` | n/a | yes |
| <a name="input_strategy"></a> [strategy](#input\_strategy) | (Required) The placement strategy of the placement group. | `string` | n/a | yes |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_partition_size"></a> [partition\_size](#input\_partition\_size) | (Optional) The number of partitions to create in the placement group. Can only be specified when the `strategy` is set to `PARTITION`. Valid values are 1 - 7. Defaults to `2`. | `number` | `2` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the placement group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the placement group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the placement group. |
| <a name="output_partition_size"></a> [partition\_size](#output\_partition\_size) | The number of partitions in the placement group. Only configured when the `strategy` is `PARTITION`. |
| <a name="output_strategy"></a> [strategy](#output\_strategy) | The placement strategy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
