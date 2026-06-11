output "cc_sg_public_id" {
  description = "Security group ID for EC2 (public traffic)"
  value       = aws_security_group.ccSGPublic.id
}

output "cc_sg_rds_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.ccSGRds.id
}