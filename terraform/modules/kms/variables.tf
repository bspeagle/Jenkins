#--------------------------------------------------------------
# KMS
#--------------------------------------------------------------
variable "name" {
  description = "The key name"
  type        = string
}

variable "description" {
  description = "Optional description of the key"
  type        = string
  default     = "KMS key for Jenkins"
}
