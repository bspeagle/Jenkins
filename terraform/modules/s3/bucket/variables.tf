#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "name" {
  description = "Name of the S3 bucket"
  type        = string
}

#--------------------------------------------------------------
# KMS
#--------------------------------------------------------------

variable "kms_arn" {
  description = "KMS key arn used for the SSE-KMS encryption"
  type        = string
}