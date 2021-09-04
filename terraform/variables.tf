#--------------------------------------------------------------
# AWS
#--------------------------------------------------------------

variable "aws_profile" {
  description = "AWS profile to use for provider authentication (.aws/)"
  type        = string
  default     = "default-cg"
}

variable "aws_region" {
  description = "AWS region to run Terraform code in"
  type        = string
  default     = "us-east-1"
}

#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "app" {
  description = "The name of the application to deploy"
  type        = string
  default     = "Jenkins"
}

variable "environment" {
  description = "The environment for the app deployment"
  type        = string
  default     = "DEV"
}

#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

variable "map_public_ip_on_launch" {
  description = "Toggle to enable public IP for resources in subnets"
  type        = bool
  default     = false
}

#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------

variable "ec2_enable_ssh" {
  description = "Toggle SSH access for EC2 instance"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = "t3.small"

}



# variable "record_name" {}

# variable "key_name" {}

# variable "ec2_ami" {}



# variable "cloud_zone" {}
