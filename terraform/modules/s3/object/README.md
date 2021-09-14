<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_id | Bucket name of S3 bucket to store files | `string` | n/a | yes |
| name | Name to give all resources | `string` | n/a | yes |
| object\_source | The source directory of files to upload | `string` | `"files/config"` | no |
| s3\_objects | Keys of objects to upload | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| blah | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
