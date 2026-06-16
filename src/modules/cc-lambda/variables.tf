variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
  default     = "ccCreditRiskCalc"
}

variable "image_uri" {
  description = "ECR image URI for the Python app packaged as a container"
  type        = string
}

variable "app_bucket_name" {
  description = "App S3 bucket the function reads uploads from / writes results to"
  type        = string
}

variable "timeout" {
  description = "Function timeout in seconds (max 900)"
  type        = number
  default     = 300
}

variable "memory_size" {
  description = "Memory in MB (also scales CPU — helps pandas/sklearn)"
  type        = number
  default     = 2048
}