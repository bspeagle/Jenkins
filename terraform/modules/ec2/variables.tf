#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "name_prefix" {
  description = "Name prefix to give all resources"
  type        = string
}

#--------------------------------------------------------------
# EC2
#--------------------------------------------------------------

variable "instance_type" {
  description = "Instance type for the instances"
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "Type of load balancer to create"
  type        = string
  default     = "application"
}

variable "load_balancer_config" {
  description = "Config for target groups and listeners"
  type        = any
}

#--------------------------------------------------------------
# ASG
#--------------------------------------------------------------

variable "asg_max_size" {
  description = "Max size of ASG"
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "Min size of ASG"
  type        = number
  default     = 1
}

variable "asg_desired_capacity" {
  description = "Desired capacity of ASG"
  type        = number
  default     = 1
}

variable "health_check_grace_period" {
  description = "Grace Period (in seconds) for ASG health check"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Check type for ASG health check"
  type        = string
  default     = "ELB"
}

#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

variable "ec2_instance_profile_name" {
  description = "The name of the IAM instance profile to associate with launched instances"
  type        = string
}

#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

variable "vpc_id" {
  description = "VPC Id for load balancer target groups"
  type        = string
}

variable "subnets" {
  description = "List of subnets to use for ASG config"
  type        = list(string)
}

#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------

variable "ec2_sg_id" {
  description = "Security Group Id for EC2"
  type        = string
}

variable "lb_sg_id" {
  description = "Security Group Id for load balancer"
  type        = string
}

# variable "s3_bucket" {}

# variable "env_file" {}

# variable "init_file" {}

# variable "plugin_script" {}

# variable "plugin_file" {}

# variable "jobs_file" {}
