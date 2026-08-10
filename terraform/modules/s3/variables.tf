variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_name" {
  description = "Unique S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}
