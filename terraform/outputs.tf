# output "generated_name" {
#   value = local.generated_name
# }

# output "password" {
#   sensitive = true
#   value     = module.random.password
# }

output "blah" {
  value = module.s3_object.blah
}