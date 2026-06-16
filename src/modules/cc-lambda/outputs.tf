output "cc_lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.ccCreditRiskCalc.function_name
}

output "cc_lambda_invoke_arn" {
  description = "Invoke ARN for API Gateway integration"
  value       = aws_lambda_function.ccCreditRiskCalc.invoke_arn
}