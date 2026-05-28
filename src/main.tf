terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      # source  = "hashicorp/aws"
      source = "trialh9yx8a.jfrog.io/aws-tf-gha-jfrog-terraform-rt-ns-hashicorp/aws"
      version = "~>3.0"
    }
  }

  backend "s3" {
    bucket         = "tf-state-backend-test-9875"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "tf-state-backend-test-9875"
}

module "vpc-infra" {
  source               = "./modules/vpc"
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}