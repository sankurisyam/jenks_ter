variable "aws_region" {
  description = "Aws Region"
  type        = string
}
variable "bucket_name" {

  description = "Unique se bucket name"
  type        = string

}
variable "environment" {

  description = "Deployment Environment"
  type        = string

}

variable "user_name" {
  description = "IAM username"
  type        = string
}