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
