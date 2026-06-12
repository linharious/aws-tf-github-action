terraform {
  required_version = ">=1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

locals {
  state_bucket_name = "tf-state-ca-central-202606"
}

import {
  to = module.cc-tf-state.aws_s3_bucket.terraform_state
  id = local.state_bucket_name
}

import {
  to = module.cc-tf-state.aws_s3_bucket_versioning.terraform_bucket_versioning
  id = local.state_bucket_name
}

import {
  to = module.cc-tf-state.aws_s3_bucket_server_side_encryption_configuration.terraform_state_crypto_conf
  id = local.state_bucket_name
}

module "cc-tf-state" {
  source      = "../modules/cc-tf-state"
  bucket_name = local.state_bucket_name
}

output "state_bucket_name" {
  description = "Name of the S3 bucket holding the main stack's remote state"
  value       = local.state_bucket_name
}