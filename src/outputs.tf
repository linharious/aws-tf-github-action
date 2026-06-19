output "cc_vpc_id" {
  description = "VPC ID"
  value       = module.cc-init.cc_vpc_id
}

output "cc_public_subnets" {
  description = "Public subnets"
  value       = module.cc-init.cc_public_subnets
}

output "cc_private_subnets" {
  description = "Private subnets"
  value       = module.cc-init.cc_private_subnets
}

output "cc_sg_public_id" {
  description = "Public-tier security group ID"
  value       = module.cc-init.cc_sg_public_id
}

output "cc_sg_rds_id" {
  description = "RDS security group ID"
  value       = module.cc-init.cc_sg_rds_id
}

output "cc_ec2_instance_profile_name" {
  description = "EC2 instance profile name"
  value       = module.cc-init.cc_ec2_instance_profile_name
}

output "cc_ec2_role_arn" {
  description = "EC2 IAM role ARN"
  value       = module.cc-init.cc_ec2_role_arn
}