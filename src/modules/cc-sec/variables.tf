variable "vpc_id" {
  description = "VPC ID to attach security groups to"
  type        = string
}

variable "environment" {
  description = "Deployment environment name (e.g. dev, staging, prod)"
  type        = string
}