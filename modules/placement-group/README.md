# placement-group

There is no charge for creating a placement group.

This module creates following resources.

- `aws_placement_group`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.32 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.32.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_placement_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the placement group. | `string` | n/a | yes |
| <a name="input_strategy"></a> [strategy](#input\_strategy) | (Required) The placement strategy of the placement group. Valid values are `CLUSTER`, `PARTITION` or `SPREAD`.<br/>    `CLUSTER` - packs instances close together inside an Availability Zone. This strategy enables workloads to achieve the low-latency network performance necessary for tightly-coupled node-to-node communication that is typical of HPC applications.<br/>    `PARTITION` - spreads your instances across logical partitions such that groups of instances in one partition do not share the underlying hardware with groups of instances in different partitions. This strategy is typically used by large distributed and replicated workloads, such as Hadoop, Cassandra, and Kafka.<br/>    `SPREAD` - strictly places a small group of instances across distinct underlying hardware to reduce correlated failures. | `string` | n/a | yes |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_partition_size"></a> [partition\_size](#input\_partition\_size) | (Optional) The number of partitions to create in the placement group. Can only be specified when the `strategy` is set to `PARTITION`. Valid values are 1 - 7. Defaults to `2`. | `number` | `2` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_spread_level"></a> [spread\_level](#input\_spread\_level) | (Optional) The spread level to determine how the placement group spread instances. Can only be specified when the `strategy` is set to `SPREAD`. Valid values are `HOST` and `RACK`. `HOST` can only be used for Outpost placement groups. | `string` | `"RACK"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the placement group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the placement group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the placement group. |
| <a name="output_partition_size"></a> [partition\_size](#output\_partition\_size) | The number of partitions in the placement group. Only configured when the `strategy` is `PARTITION`. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_spread_level"></a> [spread\_level](#output\_spread\_level) | The spread level to determine how the placement group spread instance. Only configured when the `strategy` is `SPREAD`. |
| <a name="output_strategy"></a> [strategy](#output\_strategy) | The placement strategy. |
<!-- END_TF_DOCS -->
