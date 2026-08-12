terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_instance" "main" {
  instance_type = var.instance_type

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-instance"
      Environment = var.environment
      Module      = "ec2"
    }
  )
}
