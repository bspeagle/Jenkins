#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "name" {
  description = "Name to give all resources"
  type        = string
}

#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

variable "vpc_id" {
  description = "Id of the VPC to use"
  type        = string
}

variable "ec2_enable_ssh" {
  description = "Toggle SSH access for EC2 instance"
  type        = bool
  default     = false
}