module "cc-tf-state" {
  source      = "./cc-tf-state"
  bucket_name = "tf-state-ca-central-202606"
}

module "cc-vpc" {
  source               = "./cc-vpc"
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "cc-iam" {
  source      = "./cc-iam"
  environment = var.environment
}

module "cc-sec" {
  source      = "./cc-sec"
  environment = var.environment
}
