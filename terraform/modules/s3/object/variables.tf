#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "name" {
  description = "Name to give all resources"
  type        = string
}

#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

variable "bucket_id" {
  description = "Bucket name of S3 bucket to store files"
  type        = string
}

variable "object_source" {
  description = "The source directory of files to upload"
  type        = string
  default     = "files/config"
}

variable "s3_objects" {
  description = "Keys of objects to upload"
  type        = any
  default     = []
}
