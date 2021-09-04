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
| asg\_desired\_capacity | Desired capacity of ASG | `number` | `1` | no |
| asg\_max\_size | Max size of ASG | `number` | `1` | no |
| asg\_min\_size | Min size of ASG | `number` | `1` | no |
| ec2\_instance\_profile\_name | The name of the IAM instance profile to associate with launched instances | `string` | n/a | yes |
| ec2\_sg\_id | Security Group Id for EC2 | `string` | n/a | yes |
| health\_check\_grace\_period | Grace Period (in seconds) for ASG health check | `number` | `300` | no |
| health\_check\_type | Check type for ASG health check | `string` | `"ELB"` | no |
| instance\_type | Instance type for the instances | `string` | `"t3.small"` | no |
| key\_name | The key name that should be used for the instance | `string` | `null` | no |
| lb\_sg\_id | Security Group Id for load balancer | `string` | n/a | yes |
| load\_balancer\_config | Config for target groups and listeners | `any` | n/a | yes |
| load\_balancer\_type | Type of load balancer to create | `string` | `"application"` | no |
| name\_prefix | Name prefix to give all resources | `string` | n/a | yes |
| subnets | List of subnets to use for ASG config | `list(string)` | n/a | yes |
| vpc\_id | VPC Id for load balancer target groups | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
