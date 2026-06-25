output "cc_api_calculate_url" {
  description = "Full URL of the calculate endpoint"
  value       = "${aws_apigatewayv2_api.ccApi.api_endpoint}/calculate"
}

output "cc_api_base_url" {
  description = "Base URL of the HTTP API (serves the web UI)"
  value       = aws_apigatewayv2_api.ccApi.api_endpoint
}