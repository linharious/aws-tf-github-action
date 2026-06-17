variable "repository_name" {
  description = "ECR repository name for the app container image"
  type        = string
  default     = "cc-credit-risk"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}