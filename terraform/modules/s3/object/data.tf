data "template_file" "this" {
  count = length(local.objects_with_configs)

  template = file("${path.cwd}/${var.object_source}/${local.objects_with_configs[count.index].key}")

  vars = [for object in local.objects_with_configs : [
    for config in object : config
  ][0]][0]
}