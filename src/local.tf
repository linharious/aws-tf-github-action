locals {
  environment        = "dev"
  availability_zones = ["ca-central-1a", "ca-central-1b"]

  bucket_name          = "tf-state-ca-central-202606"
  app_bucket_name      = "cc-app-bucket-202606"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}