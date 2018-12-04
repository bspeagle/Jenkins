variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "zone_id" {}
variable "record_name" {}
variable "bucket_id" {}
variable "key_name" {}

variable "app" {
  default = "jenkins"
}

variable "env" {
  default = "prod"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "s3" {
  source = "../modules/s3"
  app = "${var.app}"
  env = "${var.env}"
  bucket_id = "${var.bucket_id}"
}

module "vpc" {
  source = "../modules/vpc"
  app = "${var.app}"
  env = "${var.env}"
}

module "sec" {
  source = "../modules/sec"
  app = "${var.app}"
  env = "${var.env}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "ec2" {
  source = "../modules/ec2"
  app = "${var.app}"
  env = "${var.env}"
  vpc_id = "${module.vpc.vpc_id}"
  lbsg_id = "${module.sec.lbsg_id}"
  ec2sg_id = "${module.sec.ec2sg_id}"
  sng1_id = "${module.vpc.sng1_id}"
  sng2_id = "${module.vpc.sng2_id}"
  ec2_instance_profile_name = "${module.sec.ec2_instance_profile_name}"
  s3_bucket = "${var.bucket_id}"
  env_file = "${module.s3.envFile}"
  init_file = "${module.s3.initFile}"
  plugin_script = "${module.s3.pluginScript}"
  plugin_file = "${module.s3.pluginFile}"
  jobs_file = "${module.s3.jobsFile}"
  key_name = "${var.key_name}"
}

module "route53" {
  source = "../modules/route53"
  app = "${var.app}"
  env = "${var.env}"
  zone_id = "${var.zone_id}"
  record_name = "${var.record_name}"
  jMaster-lb-zoneId = "${module.ec2.jMaster-lb-zoneId}"
  jMaster-lb-dns = "${module.ec2.jMaster-lb-dns}"
}