resource "random_id" "this" {
  byte_length = 3
  prefix      = var.name_prefix
}

resource "random_pet" "this" {
  length    = 2
  separator = "-"
}

resource "random_string" "this" {
  length  = 16
  special = true
}