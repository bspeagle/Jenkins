variable "app" {}
variable "env" {}
variable "bucket_id" {}

resource "aws_s3_bucket_object" "envFile" {
    bucket = "${var.bucket_id}"
    acl    = "private"
    key    = "jenkins.env"
    source = "../files/jenkins.env"
}

resource "aws_s3_bucket_object" "initFile" {
    bucket = "${var.bucket_id}"
    acl    = "private"
    key    = "init.groovy"
    source = "../files/init.groovy"
}

resource "aws_s3_bucket_object" "pluginScript" {
    bucket = "${var.bucket_id}"
    acl    = "private"
    key    = "install-plugins.sh"
    source = "../files/install-plugins.sh"
}

resource "aws_s3_bucket_object" "pluginFile" {
    bucket = "${var.bucket_id}"
    acl    = "private"
    key    = "plugins.txt"
    source = "../files/plugins.txt"
}

resource "aws_s3_bucket_object" "jobsFile" {
    bucket = "${var.bucket_id}"
    acl    = "private"
    key    = "jobs.tgz"
    source = "../files/jobs.tgz"
}

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