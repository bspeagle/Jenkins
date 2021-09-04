resource "aws_s3_bucket" "this" {
  bucket = "${var.name}-filez"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags_all = {
    Name = var.name
  }
}
