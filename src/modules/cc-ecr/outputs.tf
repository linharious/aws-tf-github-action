output "cc_ecr_repository_url" {
  description = "ECR repo URL — base for the Lambda image URI"
  value       = aws_ecr_repository.ccEcrRepo.repository_url
}

output "cc_ecr_repository_arn" {
  description = "ECR repository ARN"
  value       = aws_ecr_repository.ccEcrRepo.arn
}