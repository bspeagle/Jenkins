terraform {
  required_providers {}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      App = var.app
      Env = var.environment
    }
  }
}
