variable "bucket_name" {
  description = "Name of the application S3 bucket (upload + results)"
  type        = string
}

variable "environment" {
  description = "Deployment env name"
  type        = string
}