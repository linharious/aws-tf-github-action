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

import {
  to = module.tf-state.aws_s3_bucket.terraform_state
  id = "tf-state-ca-central-202606"
}

module "cc-init" {
  source = "./modules/cc-init"
}