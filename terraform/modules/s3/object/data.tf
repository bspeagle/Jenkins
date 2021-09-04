data "template_file" "this" {
  count = length(local.objects_with_configs)

  template = file("${path.cwd}/${var.object_source}/${local.objects_with_configs[count.index].key}")

  vars = {
    admin_username = lookup(local.objects_with_configs[count.index].config, "admin_username", "username")
    admin_password = lookup(local.objects_with_configs[count.index].config, "admin_password", "password")
  }
}