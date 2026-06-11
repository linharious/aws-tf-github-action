output "cc_ec2_instance_profile_name" {
  description = "Instance profile to attach to EC2"
  value       = aws_iam_instance_profile.ccEC2InstanceProfile.name
}

output "cc_ec2_role_arn" {
  description = "IAM Role ARN for EC2"
  value       = aws_iam_role.ccEC2Role.arn
}