terraform {
  required_version = ">=1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "s3" {
    bucket       = "tf-state-ca-central-202606"
    key          = "global/s3/terraform.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "ca-central-1"
}

module "cc-init" {
  source               = "./modules/cc-init"
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  environment          = local.environment
  app_bucket_name      = local.app_bucket_name
  lambda_image_uri     = local.lambda_image_uri
}