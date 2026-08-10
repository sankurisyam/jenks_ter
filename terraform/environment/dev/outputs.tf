output "bucket_name" {
  description = "S3 Bucket Name"
  value       = module.s3.bucket_name
}

output "bucket_arn" {
  description = "S3 Bucket ARN"
  value       = module.s3.bucket_arn
}
output "aws_key_id" {
  description = "AWS Access Key ID"
  value       = module.iam.aws_key_id
  sensitive   = true

}

output "secret_access_key" {
  description = "AWS Secret Access Key"
  value       = module.iam.secret_access_key
  sensitive   = true
}