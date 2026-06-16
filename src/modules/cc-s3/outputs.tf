output "cc_app_bucket_id" {
  description = "App S3 bucket name"
  value       = aws_s3_bucket.ccAppBucket.id
}

output "cc_app_bucket_arn" {
  description = "App S3 bucket ARN"
  value       = aws_s3_bucket.ccAppBucket.arn
}