# instance

This module creates following resources.

- `aws_instance` (optional)
- `aws_spot_instance_request` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_spot_instance_request.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the instance. | `string` | n/a | yes |
| <a name="input_auto_recovery_enabled"></a> [auto\_recovery\_enabled](#input\_auto\_recovery\_enabled) | (Optional) Whether to enable auto-recovery for the instance. Instance auto-recovery recovers your instance if system status checks fail. By default, shared tenancy without local storage and GPUs are set to auto-recover. | `bool` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional) AZ (Availability Zone) to create the instance in. | `string` | `null` | no |
| <a name="input_cpu_credit_specification"></a> [cpu\_credit\_specification](#input\_cpu\_credit\_specification) | (Optional) The specification for CPU credit. A credit specification is only available for T2, T3, and T3a instances. Valid values are `STANDARD` or `UNLIMITED`. T3 instances are launched as `UNLIMITED` by default. T2 instances are launched as `STANDARD` by default. | `string` | `null` | no |
| <a name="input_cpu_options"></a> [cpu\_options](#input\_cpu\_options) | (Optional) The configuration of the CPU options to optimize the instance for specific workloads or business needs. You can specify these CPU options during instance launch. There is no additional or reduced charge for specifying CPU options. `cpu_options` block as defined below.<br>    (Optional) `core_count` - Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API.<br>    (Optional) `threads_per_core` - Set the number of CPU threads per core for the instance. If set to to 1, hyperthreading is disabled on the launched instance. | <pre>object({<br>    core_count       = number<br>    threads_per_core = number<br>  })</pre> | `null` | no |
| <a name="input_instance_ami"></a> [instance\_ami](#input\_instance\_ami) | (Optional) The AMI to run on the instance. | `string` | `null` | no |
| <a name="input_instance_ssh_key"></a> [instance\_ssh\_key](#input\_instance\_ssh\_key) | (Optional) The name of the SSH Key that should be used to access the instance. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional) The type of the instance. | `string` | `null` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | (Optional) If true, the launched EC2 instance will have detailed monitoring enabled. | `bool` | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_shutdown_behavior"></a> [shutdown\_behavior](#input\_shutdown\_behavior) | (Optional) The instance behavior when an OS-level shutdown is performed. Instances can be either terminated or stopped. Valid values are `STOP` or `TERMINATE`. Amazon defaults this to `STOP` for EBS-backed instances and `TERMINATE` for instance-store instances. Cannot be set on instance-store instances. | `string` | `null` | no |
| <a name="input_spot_enabled"></a> [spot\_enabled](#input\_spot\_enabled) | (Optional) Whether to create the instance as a spot instance. | `bool` | `false` | no |
| <a name="input_stop_protection_enabled"></a> [stop\_protection\_enabled](#input\_stop\_protection\_enabled) | (Optional) Indicates whether stop of the instance via the AWS API will be protected. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Optional) The ID of subnet in which to launch the instance. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | (Optional) Indicates whether termination of the instance via the AWS API will be protected. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the instance to be created/updated/deleted. | `map(string)` | <pre>{<br>  "create": "10m",<br>  "delete": "20m",<br>  "update": "10m"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the instance. |
| <a name="output_attributes"></a> [attributes](#output\_attributes) | A set of attributes that applied to the instance. |
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The Availability Zone of the instance. |
| <a name="output_cpu_credit_specification"></a> [cpu\_credit\_specification](#output\_cpu\_credit\_specification) | The CPU credit specification for the instance. |
| <a name="output_cpu_options"></a> [cpu\_options](#output\_cpu\_options) | The CPU options for the instance. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the instance. |
| <a name="output_private_domain"></a> [private\_domain](#output\_private\_domain) | The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address assigned to the instance. |
| <a name="output_public_domain"></a> [public\_domain](#output\_public\_domain) | The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws\_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached. |
| <a name="output_state"></a> [state](#output\_state) | The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of subnet of the launched instance. |
| <a name="output_test"></a> [test](#output\_test) | The configuration of rule groups associated with the firewall. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
