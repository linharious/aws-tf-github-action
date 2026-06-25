resource "aws_apigatewayv2_api" "ccApi" {
  name          = "ccApi-${var.environment}"
  protocol_type = "HTTP"

  tags = {
    Name        = "ccApi-${var.environment}"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

resource "aws_apigatewayv2_integration" "ccApiLambda" {
  api_id                 = aws_apigatewayv2_api.ccApi.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "ccApiRoute" {
  api_id    = aws_apigatewayv2_api.ccApi.id
  route_key = "POST /calculate"
  target    = "integrations/${aws_apigatewayv2_integration.ccApiLambda.id}"
}

# Catch-all so the FastAPI app also serves the UI pages and static assets;
# Mangum dispatches paths internally.
resource "aws_apigatewayv2_route" "ccApiDefaultRoute" {
  api_id    = aws_apigatewayv2_api.ccApi.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.ccApiLambda.id}"
}

resource "aws_apigatewayv2_stage" "ccApiStage" {
  api_id      = aws_apigatewayv2_api.ccApi.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "ccApiInvoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.ccApi.execution_arn}/*/*"
}