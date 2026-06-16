resource "aws_s3_bucket" "ccAppBucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "ccAppBucketPAB" {
  bucket                  = aws_s3_bucket.ccAppBucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ccAppBucketEnc" {
  bucket = aws_s3_bucket.ccAppBucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "ccAppBucketLifecycle" {
  bucket = aws_s3_bucket.ccAppBucket.id
  rule {
    id     = "expire-old-objects"
    status = "Enabled"
    filter {}
    expiration {
      days = 30
    }
  }
}