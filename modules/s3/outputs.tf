output "env_file" {
  value = "${aws_s3_bucket_object.env_file.key}"
}

output "init_file" {
  value = "${aws_s3_bucket_object.init_file.key}"
}

output "plugin_script" {
  value = "${aws_s3_bucket_object.plugin_script.key}"
}

output "plugin_file" {
  value = "${aws_s3_bucket_object.plugin_file.key}"
}

output "jobs_file" {
  value = "${aws_s3_bucket_object.jobs_file.key}"
}

output "s3_bucket" {
  value = "${aws_s3_bucket.jenkins_filez.id}"
}
