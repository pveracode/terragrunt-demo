include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path = find_in_parent_folders("env.hcl")
}

terraform {
  source = "../../../../../../modules/ec2"
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  environment   = local.env.locals.environment
  instance_type = local.env.locals.instance_type
  tags          = local.env.locals.tags
}
