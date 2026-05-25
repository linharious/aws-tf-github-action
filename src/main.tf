terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>3.0"
    }
  }

  backend "s3" {
    bucket = "tf-state-backend-test-9875"
    key = "global/s3/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}

provider "aws" {
  region = "us-west-2"
}

module "tf-state" {
    source = "./modules/tf-state"
    bucket_name = "tf-state-backend-test-9875"
}