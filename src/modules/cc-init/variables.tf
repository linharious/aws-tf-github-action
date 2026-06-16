variable "app_bucket_name" {
  description = "S3 bucket name the EC2 app is allowed to access"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "availability_zones" {
  description = "AZs for Subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for Public Subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for Private Subnets"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment name (dev, staging, prod)"
  type        = string
}

variable "lambda_image_uri" {
  description = "ECR image URI for the Python app packaged as a container"
  type        = string
}