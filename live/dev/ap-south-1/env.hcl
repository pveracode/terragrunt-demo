locals {
  environment = "dev"

  region = "ap-south-1"

  bucket_name = "terragrunt-demo-dev-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  instance_type = "t3.micro"

  tags = {
    Environment = local.environment
    CreatedBy   = "Terragrunt Demo"
  }
}
