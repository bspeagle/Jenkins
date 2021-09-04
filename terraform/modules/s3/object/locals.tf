locals {
  objects_with_configs = [
    for object in var.s3_objects : object
    if lookup(object, "config", "") != ""
  ]

  objects_without_configs = [
    for object in var.s3_objects : object
    if lookup(object, "config", "") == ""
  ]
}