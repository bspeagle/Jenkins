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
    # {
    #   key = "aws_s3_boot_tasks.sh"
    #   config = {
    #     s3_bucket     = "",
    #     env_file      = "",
    #     init_file     = "",
    #     plugin_script = "",
    #     plugin_file   = "",
    #     jobs_file     = ""
    #   }
    # }
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
