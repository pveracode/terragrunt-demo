terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.region}"

      default_tags {
        tags = {
          Project     = "${local.project}"
          Environment = "${local.environment}"
          ManagedBy   = "Terragrunt"
          CreatedAt   = "2024"
        }
      }
    }
  EOF
}


remote_state {
  backend = "s3"

  config = {
    bucket         = "terragrunt-demo-state-YOUR-UNIQUE-ID"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}


locals {
  region = "ap-south-1"

  project = "terragrunt-demo"

  environment = basename(dirname(dirname(get_terragrunt_dir())))

  aws_account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}
