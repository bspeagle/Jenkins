provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "s3" {
  source = "../modules/s3"
  app = "${var.app}"
  env = "${var.env}"
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
  lb_sg_id = "${module.sec.lb_sg_id}"
  ec2_sg_id = "${module.sec.ec2_sg_id}"
  ec2_instance_profile_name = "${module.sec.ec2_instance_profile_name}"
  s3_bucket = "${module.s3.s3_bucket}"
  env_file = "${module.s3.env_file}"
  init_file = "${module.s3.init_file}"
  plugin_script = "${module.s3.plugin_script}"
  plugin_file = "${module.s3.plugin_file}"
  jobs_file = "${module.s3.jobs_file}"
  key_name = "${var.key_name}"
  ec2_ami = "${var.ec2_ami}"
  leader_instance_type = "${var.leader_instance_type}"
  subnets = "${module.vpc.subnets}"
}

module "route53" {
  source = "../modules/route53"
  app = "${var.app}"
  env = "${var.env}"
  cloud_zone = "${var.cloud_zone}"
  record_name = "${var.record_name}"
  leader_lb_zone = "${module.ec2.leader_lb_zone}"
  leader_lb_dns = "${module.ec2.leader_lb_dns}"
}