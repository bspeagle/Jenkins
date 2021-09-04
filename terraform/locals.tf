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
    },
    # {
    #   protocol = "HTTP"
    #   config = [
    #     {
    #       type = "target_group"
    #       port = 8080
    #     },
    #     {
    #       type = "listener"
    #       port = 80
    #     }
    #   ]
    # },
  ]
}