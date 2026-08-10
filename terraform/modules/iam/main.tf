resource "aws_iam_user" "image_app" {
  name = var.user_name

  tags = {
    project  = "image-app"
    mangedby = "terraform"
  }

}
data "aws_iam_policy_document" "image_upload" {
  statement {
    effect = "Allow"
    actions = ["s3:PutObject",
    "s3:GetObject"]


    resources = ["${var.bucket_arn}/*"]
  }
}
resource "aws_iam_policy" "image_upload" {
  name   = "image-upload"
  policy = data.aws_iam_policy_document.image_upload.json
}
resource "aws_iam_user_policy_attachment" "image_upload" {
  user       = aws_iam_user.image_app.name
  policy_arn = aws_iam_policy.image_upload.arn
}

resource "aws_iam_access_key" "image_app" {
  user = aws_iam_user.image_app.name
}