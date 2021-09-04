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

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_segment_start" {
  type    = number
  default = 10
}

variable "subnet_count" {
  description = "Count of subnets to create for VPC"
  type        = number
  default     = 2
}

variable "map_public_ip_on_launch" {
  description = "Toggle to enable public IP for resources in subnets"
  type        = bool
  default     = false
}