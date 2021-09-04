output "name" {
  description = "The key pair name."
  value       = aws_key_pair.this.key_name
}

output "file_name" {
  description = "The key pair file name in the S3 bucket."
  value       = var.file_name
}

output "file_path" {
  description = "The key pair file path in the S3 bucket."
  value       = "${var.bucket_dir}/${var.file_name}"
}

output "pem" {
  description = "The key pair pem file contents."
  value       = tls_private_key.this.private_key_pem
}
