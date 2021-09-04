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
| cidr\_block | n/a | `string` | `"10.0.0.0/16"` | no |
| map\_public\_ip\_on\_launch | Toggle to enable public IP for resources in subnets | `bool` | `false` | no |
| name | Name to give all resources | `string` | n/a | yes |
| subnet\_count | Count of subnets to create for VPC | `number` | `2` | no |
| subnet\_segment\_start | n/a | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| subnets | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
