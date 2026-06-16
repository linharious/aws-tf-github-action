variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda to integrate"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name (for invoke permission)"
  type        = string
}