resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "this" {
  key_name   = var.name_prefix
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = var.name_prefix
  }
}

resource "aws_s3_bucket_object" "this" {
  bucket  = var.bucket_id
  key     = "${var.bucket_dir}/${var.file_name}"
  content = tls_private_key.this.private_key_pem

  tags = {
    Name = var.name_prefix
  }
}

# Write key-pair pem to file
resource "local_file" "this" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.root}/generated_keypair/${var.name_prefix}.pem"
  file_permission = "0400"
}
