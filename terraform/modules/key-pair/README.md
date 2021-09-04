<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_dir | Path to store key-pair file | `string` | `"/key_pair"` | no |
| bucket\_id | Name of the bucket to store key-pair file in | `string` | n/a | yes |
| file\_name | Filename of key-pair pem file | `string` | `"jenkins.pem"` | no |
| name\_prefix | Naming prefix for resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| file\_name | The key pair file name in the S3 bucket. |
| file\_path | The key pair file path in the S3 bucket. |
| name | The key pair name. |
| pem | The key pair pem file contents. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
