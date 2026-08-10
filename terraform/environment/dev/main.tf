module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
  environment = var.environment
  aws_region  = var.aws_region

}

module "iam" {
  source     = "../../modules/iam"
  user_name  = var.user_name
  bucket_arn = module.s3.bucket_arn

}
