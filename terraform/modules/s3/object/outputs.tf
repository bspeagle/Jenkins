# output "file_key" {
#   description = "File key(s) of the uploaded file(s)"
#   value = merge(
#     aws_s3_bucket_object.with_config.*.key,
#     aws_s3_bucket_object.without_config.*.key
#   )
# }
