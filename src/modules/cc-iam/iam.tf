# Role attached to EC2 instance
resource "aws_iam_role" "ccEC2Role" {
  name = "ccEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "ccEC2Role"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

# Allow EC2 to read/write S3
resource "aws_iam_role_policy" "ccEC2S3Policy" {
  name = "ccEC2S3Policy"
  role = aws_iam_role.ccEC2Role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.app_bucket_name}",
          "arn:aws:s3:::${var.app_bucket_name}/*"
        ]
      }
    ]
  })
}

# Allow EC2 to write logs to CloudWatch
resource "aws_iam_role_policy_attachment" "ccEC2CloudWatchPolicy" {
  role       = aws_iam_role.ccEC2Role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Allow EC2 to use SSM (remote access without SSH key)
resource "aws_iam_role_policy_attachment" "ccEC2SSMPolicy" {
  role       = aws_iam_role.ccEC2Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile — wrapper that attaches the Role to EC2
resource "aws_iam_instance_profile" "ccEC2InstanceProfile" {
  name = "ccEC2InstanceProfile"
  role = aws_iam_role.ccEC2Role.name

  tags = {
    Name        = "ccEC2InstanceProfile"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}