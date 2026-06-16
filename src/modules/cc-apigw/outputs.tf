output "cc_api_calculate_url" {
  description = "Full URL of the calculate endpoint"
  value       = "${aws_apigatewayv2_api.ccApi.api_endpoint}/calculate"
}