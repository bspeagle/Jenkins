variable "app" {}

variable "env" {}

variable "vpc_id" {}

variable "ec2_sg_id" {}

variable "lb_sg_id" {}

variable "ec2_instance_profile_name" {}

variable "s3_bucket" {}

variable "env_file" {}

variable "init_file" {}

variable "plugin_script" {}

variable "plugin_file" {}

variable "jobs_file" {}

variable "key_name" {}

variable "ec2_ami" {}

variable "leader_instance_type" {}

variable "subnets" {
  type = "list"
}
