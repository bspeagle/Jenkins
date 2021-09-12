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
| app | The name of the application to deploy | `string` | `"Jenkins"` | no |
| aws\_profile | AWS profile to use for provider authentication (.aws/) | `string` | `null` | no |
| aws\_region | AWS region to run Terraform code in | `string` | `"us-east-1"` | no |
| ec2\_enable\_ssh | Toggle SSH access for EC2 instance | `bool` | `false` | no |
| environment | The environment for the app deployment | `string` | `"DEV"` | no |
| instance\_type | The size of instance to launch | `string` | `"t3.small"` | no |
| map\_public\_ip\_on\_launch | Toggle to enable public IP for resources in subnets | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| generated\_name | n/a |
| password | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
