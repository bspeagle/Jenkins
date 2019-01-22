output "envFile" {
  value = "${aws_s3_bucket_object.envFile.key}"
}

output "initFile" {
  value = "${aws_s3_bucket_object.initFile.key}"
}

output "pluginScript" {
  value = "${aws_s3_bucket_object.pluginScript.key}"
}

output "pluginFile" {
  value = "${aws_s3_bucket_object.pluginFile.key}"
}

output "jobsFile" {
  value = "${aws_s3_bucket_object.jobsFile.key}"
}