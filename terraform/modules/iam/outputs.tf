output "aws_key_id" {
  value = aws_iam_access_key.image_app.id
  sensitive = true
}
output "secret_access_key" {
  value = aws_iam_access_key.image_app.secret
  sensitive = true
}