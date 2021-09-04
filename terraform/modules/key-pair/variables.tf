#--------------------------------------------------------------
# General
#--------------------------------------------------------------

variable "name_prefix" {
  description = "Naming prefix for resources"
  type        = string
}

#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

variable "bucket_id" {
  description = "Name of the bucket to store key-pair file in"
  type        = string
}

variable "bucket_dir" {
  description = "Path to store key-pair file"
  type        = string
  default     = "/key_pair"
}

variable "file_name" {
  description = "Filename of key-pair pem file"
  type        = string
  default     = "jenkins.pem"
}
