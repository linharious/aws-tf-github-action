# Allow HTTP/HTTPS traffic from internet to EC2
resource "aws_security_group" "ccSGPublic" {
  name   = "ccSGPublic"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ccSGPublic"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}

# Allow DB traffic only from EC2 security group
resource "aws_security_group" "ccSGRds" {
  name   = "ccSGRds"
  vpc_id = var.vpc_id

  ingress {
    description     = "PostgreSQL from EC2 only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ccSGPublic.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ccSGRds"
    Project     = "AWS TF Github Action"
    Environment = var.environment
  }
}