locals {
  environment = "prod"

  region = "ap-south-1"

  bucket_name = "terragrunt-demo-prod-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  instance_type = "t3.small"

  tags = {
    Environment = local.environment
    CreatedBy   = "Terragrunt Demo"
  }
}
