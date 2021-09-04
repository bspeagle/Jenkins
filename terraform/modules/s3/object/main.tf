resource "aws_s3_bucket_object" "with_config" {
  count = length(local.objects_with_configs)

  bucket = var.bucket_id
  key    = var.s3_objects[count.index].key

  content = data.template_file.this[count.index].rendered

  tags_all = {
    Name = var.name
  }
}

resource "aws_s3_bucket_object" "without_config" {
  count = length(local.objects_without_configs)

  bucket = var.bucket_id
  key    = local.objects_without_configs[count.index].key

  source = "${path.cwd}/${var.object_source}/${local.objects_without_configs[count.index].key}"

  tags_all = {
    Name = var.name
  }
}