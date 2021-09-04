data "aws_default_tags" "this" {}

data "aws_ami" "this" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# data "template_file" "user_data_jenkins" {
#   template = "${file("../files//user_data/user_data_jenkins.tpl")}"

#   vars = {
#     s3_bucket = "${var.s3_bucket}"
#     env_file = "${var.env_file}"
#     init_file = "${var.init_file}"
#     plugin_script = "${var.plugin_script}"
#     plugin_file = "${var.plugin_file}"
#     jobs_file = "${var.jobs_file}"
#   }
# }

# data "template_file" "this" {
#   template = file("${path.module}/templates/userdata.tpl")

#   vars = {
#     # Agent
#     "agent_username" = "${var.agent_username}"

#     # EBS
#     "ebs_device_name" = "${local.ebs_secondary_device_name}"
#     "ebs_directory"   = "${local.ebs_directory}"

#     # EFS
#     "efs_directory"  = "${local.efs_directory}"
#     "file_system_id" = "${module.efs.id}"

#     # S3
#     "s3_bucket"     = "${module.s3_bucket.id[0]}"
#     "s3_object_key" = "${aws_s3_bucket_object.this.key}"
#   }
# }

# data "template_cloudinit_config" "this" {
#   gzip          = true
#   base64_encode = true

#   part {
#     filename     = "userdata.cfg"
#     content_type = "text/cloud-config"
#     content      = data.template_file.this.rendered
#   }
# }
