locals {
  generated_name = lower(module.random.id)

  s3_objects = [
    {
      key = "jenkins.env"
      config = {
        admin_username = module.random.pet_name,
        admin_password = module.random.password
      }
    },
    {
      key = "init.groovy"
    },
    {
      key = "install-plugins.sh"
    },
    {
      key = "plugins.txt"
    },
    {
      key = "jobs.tgz"
    },
    {
      key = "aws_s3_boot_tasks.sh"
      config = {
        "s3_bucket"     = module.s3_bucket.id,
        "env_file"      = "jenkins.env",
        "init_file"     = "init.groovy",
        "plugin_script" = "install_plugins.sh",
        "plugin_file"   = "plugins.txt",
        "jobs_file"     = "jobs.tgz"
      }
    }
  ]

  load_balancer_config = [
    {
      protocol = "HTTP"
      config = [
        {
          type = "target_group"
          port = 8080
        },
        {
          type = "listener"
          port = 80
        }
      ]
    }
  ]
}
