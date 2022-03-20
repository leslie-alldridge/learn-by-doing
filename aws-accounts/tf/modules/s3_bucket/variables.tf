variable "name" {
  type        = string
  description = "Name of S3 Bucket"
}

variable "acl" {
  type        = string
  description = "ACL for S3 Bucket"
  default     = "private"
}

variable "region" {
  type        = string
  description = "region for S3 bucket"
  default     = "ap-southeast-2"
}

variable "versioning" {
  type        = string
  description = "Bucket versioning Disabled/Enabled"
  default     = "Disabled"
}
