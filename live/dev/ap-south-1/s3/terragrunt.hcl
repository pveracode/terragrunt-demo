include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path = find_in_parent_folders("env.hcl")
}

terraform {
  source = "../../../../../../modules/s3"
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}


inputs = {
  bucket_name = local.env.locals.bucket_name
  environment = local.env.locals.environment
  tags        = local.env.locals.tags
}
