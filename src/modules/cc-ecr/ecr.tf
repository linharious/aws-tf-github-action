resource "aws_ecr_repository" "ccEcrRepo" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.repository_name
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

resource "aws_ecr_lifecycle_policy" "ccEcrLifecycle" {
  repository = aws_ecr_repository.ccEcrRepo.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}