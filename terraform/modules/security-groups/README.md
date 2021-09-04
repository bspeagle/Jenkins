<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ec2\_enable\_ssh | Toggle SSH access for EC2 instance | `bool` | `false` | no |
| name | Name to give all resources | `string` | n/a | yes |
| vpc\_id | Id of the VPC to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ec2\_instance\_profile\_name | n/a |
| ec2\_sg\_id | Id of ec2 security group |
| lb\_sg\_id | Id of load balancer security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
