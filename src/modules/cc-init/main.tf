module "cc-iam" {
  source          = "../cc-iam"
  environment     = var.environment
  app_bucket_name = var.app_bucket_name
}

module "cc-vpc" {
  source               = "../cc-vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment          = var.environment
}

module "cc-sec" {
  source      = "../cc-sec"
  environment = var.environment
  vpc_id      = module.cc-vpc.cc_vpc_id
}

module "cc-s3" {
  source      = "../cc-s3"
  bucket_name = var.app_bucket_name
  environment = var.environment
}

# module "cc-lambda" {
#   source          = "../cc-lambda"
#   environment     = var.environment
#   image_uri       = var.lambda_image_uri
#   app_bucket_name = module.cc-s3.cc_app_bucket_id
# }

# module "cc-apigw" {
#   source               = "../cc-apigw"
#   environment          = var.environment
#   lambda_invoke_arn    = module.cc-lambda.cc_lambda_invoke_arn
#   lambda_function_name = module.cc-lambda.cc_lambda_function_name
# }