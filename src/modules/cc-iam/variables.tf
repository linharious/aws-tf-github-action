variable "environment" {
  description = "Deployment environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "app_bucket_name" {
  description = "S3 bucket name the EC2 app is allowed to access"
  type        = string
}