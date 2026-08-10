resource "aws_s3_bucket" "images" {
  bucket = var.bucket_name

  tags = {
    Name        = "Image Storage"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Team        = "Platform"
  }
}

resource "aws_s3_bucket_versioning" "images" {
  bucket = aws_s3_bucket.images.id

  versioning_configuration {
    status = "Enabled"
  }

}
resource "aws_s3_bucket_server_side_encryption_configuration" "images" {

  bucket = aws_s3_bucket.images.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_public_access_block" "images" {
  bucket = aws_s3_bucket.images.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true


}



