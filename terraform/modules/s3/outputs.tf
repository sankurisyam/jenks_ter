output "bucket_name" {
  description = "S3 Bucket Name"

  value = aws_s3_bucket.images.bucket
}

output "bucket_arn" {
  description = "s3 bucket arn"
  value       = aws_s3_bucket.images.arn
}