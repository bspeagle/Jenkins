# output "file_key" {
#   description = "File key(s) of the uploaded file(s)"
#   value = concat(
#     aws_s3_bucket_object.with_config.*.key,
#     aws_s3_bucket_object.without_config.*.key
#   )
# }

output "blah" {
  # value = [for object in local.objects_with_configs : [
  #   for config in object : config
  #   ][0]
  # ][1]
  value = local.objects_with_configs
}