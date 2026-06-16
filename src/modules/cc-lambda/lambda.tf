resource "aws_iam_role" "ccLambdaRole" {
  name = "ccLambdaRole-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "ccLambdaRole-${var.environment}"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ccLambdaLogs" {
  role       = aws_iam_role.ccLambdaRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "ccLambdaS3Policy" {
  name = "ccLambdaS3Policy"
  role = aws_iam_role.ccLambdaRole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
      Resource = [
        "arn:aws:s3:::${var.app_bucket_name}",
        "arn:aws:s3:::${var.app_bucket_name}/*"
      ]
    }]
  })
}

resource "aws_lambda_function" "ccCreditRiskCalc" {
  function_name = "${var.function_name}-${var.environment}"
  role          = aws_iam_role.ccLambdaRole.arn
  package_type  = "Image"
  image_uri     = var.image_uri
  timeout       = var.timeout
  memory_size   = var.memory_size

  environment {
    variables = {
      APP_BUCKET = var.app_bucket_name
    }
  }

  tags = {
    Name        = "${var.function_name}-${var.environment}"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}