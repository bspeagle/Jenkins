module "random" {
  source = "./modules/random"

  name_prefix = "${var.app}-${var.environment}-"
}

module "kms" {
  source = "./modules/kms"

  name = local.generated_name
}

module "s3_bucket" {
  source = "./modules/s3/bucket"

  name    = local.generated_name
  kms_arn = module.kms.arn
}

module "s3_object" {
  source = "./modules/s3/object"

  name       = local.generated_name
  bucket_id  = module.s3_bucket.id
  s3_objects = local.s3_objects
}

# module "key_pair" {
#   source = "./modules/key-pair"

#   name_prefix = local.generated_name
#   bucket_id   = module.s3_bucket.id
# }

# module "vpc" {
#   source = "./modules/vpc"

#   name                    = local.generated_name
#   map_public_ip_on_launch = var.map_public_ip_on_launch
# }

# module "security_groups" {
#   source = "./modules/security-groups"

#   name           = local.generated_name
#   vpc_id         = module.vpc.id
#   ec2_enable_ssh = var.ec2_enable_ssh
# }

# module "ec2" {
#   source = "./modules/ec2"

#   name_prefix = local.generated_name

#   vpc_id  = module.vpc.id
#   subnets = module.vpc.subnets

#   lb_sg_id                  = module.security_groups.lb_sg_id
#   ec2_sg_id                 = module.security_groups.ec2_sg_id
#   ec2_instance_profile_name = module.security_groups.ec2_instance_profile_name

#   key_name = module.key_pair.name

#   load_balancer_config = local.load_balancer_config

#   # s3_bucket     = module.s3_bucket.s3_bucket
#   # env_file      = module.s3_object.env_file
#   # init_file     = module.s3_object.init_file
#   # plugin_script = module.s3_object.plugin_script
#   # plugin_file   = module.s3_object.plugin_file
#   # jobs_file     = module.s3_object.jobs_file
# }

# # module "route53" {
# #   source = "../modules/route53"
# #   app = "${var.app}"
# #   env = "${var.env}"
# #   cloud_zone = "${var.cloud_zone}"
# #   record_name = "${var.record_name}"
# #   leader_lb_zone = "${module.ec2.leader_lb_zone}"
# #   leader_lb_dns = "${module.ec2.leader_lb_dns}"
# # }
