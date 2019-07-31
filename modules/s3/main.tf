resource "aws_s3_bucket" "jenkins_filez" {
  bucket = "${var.app}-${var.env}-cg-filez"

  tags = {
    Name = "${var.app}-${var.env}-cg-filez"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "env_file" {
  bucket = "${aws_s3_bucket.jenkins_filez.id}"
  key = "jenkins.env"
  source = "../files/config/jenkins.env"

  tags = {
    Name = "${var.app}-${var.env}-env-file"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "init_file" {
  bucket = "${aws_s3_bucket.jenkins_filez.id}"
  key = "init.groovy"
  source = "../files/config/init.groovy"

  tags = {
    Name = "${var.app}-${var.env}-init-file"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "plugin_script" {
  bucket = "${aws_s3_bucket.jenkins_filez.id}"
  key = "install-plugins.sh"
  source = "../files/config/install_plugins.sh"

  tags = {
    Name = "${var.app}-${var.env}-plugin-script"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "plugin_file" {
  bucket = "${aws_s3_bucket.jenkins_filez.id}"
  key = "plugins.txt"
  source = "../files/config/plugins.txt"

  tags = {
    Name = "${var.app}-${var.env}-plugin-file"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "jobs_file" {
  bucket = "${aws_s3_bucket.jenkins_filez.id}"
  key = "jobs.tgz"
  source = "../files/config/jobs.tgz"

  tags = {
    Name = "${var.app}-${var.env}-jobs-file"
    App = "${var.app}"
    Env = "${var.env}"
  }
}