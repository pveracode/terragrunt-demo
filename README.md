# Terragrunt Demo

A simple hands-on demo to learn Terragrunt basics with minimal complexity.

---

## What We're Building

- **S3 Bucket** - Simple storage
- **EC2 Instance** - Compute resource
- **2 Environments** - Dev and Prod
- **Same modules, different values** - That's Terragrunt!

---

## Structure

```
modules/
  ├── s3/          # S3 bucket module
  └── ec2/         # EC2 instance module

live/
  ├── root.hcl     # Shared config
  ├── dev/         # Dev environment
  │   └── ap-south-1/
  │       ├── env.hcl
  │       ├── s3/terragrunt.hcl
  │       └── ec2/terragrunt.hcl
  └── prod/        # Prod environment
      └── ap-south-1/
          ├── env.hcl
          ├── s3/terragrunt.hcl
          └── ec2/terragrunt.hcl
```

---

## Prerequisites

```bash
terraform --version       # v1.0+
terragrunt --version      # v0.56.0+
aws --version
aws configure --profile demo
export AWS_PROFILE=demo
```

---

## Quick Start

### 1. Create S3 Bucket for State

```bash
BUCKET_NAME="terragrunt-demo-state-$(date +%s)"
aws s3 mb s3://$BUCKET_NAME --region ap-south-1

# Update live/root.hcl with bucket name
```

### 2. Deploy Dev Environment

```bash
cd live/dev/ap-south-1

terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
```

### 3. Deploy Prod Environment

```bash
cd ../../prod/ap-south-1

terragrunt run-all apply
```

### 4. Cleanup

```bash
cd live/dev/ap-south-1
terragrunt run-all destroy

cd ../../prod/ap-south-1
terragrunt run-all destroy
```

---

## What You Learn

✅ Reusable Terraform modules  
✅ Environment-specific values (dev vs prod)  
✅ Configuration inheritance (include)  
✅ Terragrunt inputs and locals  
✅ Remote state management  
✅ Running multiple components with run-all  

---

## Key Concepts

| Concept | What It Does |
|---------|-------------|
| **Module** | Reusable Terraform code (modules/s3, modules/ec2) |
| **Terragrunt** | Orchestrates modules across environments |
| **env.hcl** | Environment-specific values (bucket_name, instance_type) |
| **terragrunt.hcl** | Connects module + env values |
| **root.hcl** | Shared config (provider, remote state) |
| **include** | Inherit config from parent files |
| **inputs** | Pass values from Terragrunt to Terraform |

---

## How It Works

```
env.hcl (values)
    ↓
terragrunt.hcl (passes to module)
    ↓
modules/ (creates resources)
    ↓
AWS (S3 + EC2 created)
```

**Dev and Prod use the SAME modules with DIFFERENT values.**

---

## Single Component Commands

```bash
# Just S3
cd live/dev/ap-south-1/s3
terragrunt init
terragrunt plan
terragrunt apply

# Just EC2
cd ../ec2
terragrunt init
terragrunt plan
terragrunt apply
```

---

## Troubleshooting

**AWS Credentials Error**
```bash
aws sts get-caller-identity
aws configure --profile demo
export AWS_PROFILE=demo
```

**Module Not Found**
```bash
pwd  # Check you're in right directory
ls ../../../../modules/  # Verify modules exist
```

**S3 State Bucket Missing**
```bash
BUCKET_NAME="terragrunt-demo-state-$(date +%s)"
aws s3 mb s3://$BUCKET_NAME --region ap-south-1
# Update live/root.hcl
```

---

## Files Explained

- **modules/s3/main.tf** - S3 bucket resource definition
- **modules/ec2/main.tf** - EC2 instance resource definition
- **modules/*/variables.tf** - Input variables
- **modules/*/outputs.tf** - Output values
- **live/root.hcl** - Shared: provider, backend, terraform version
- **live/dev/ap-south-1/env.hcl** - Dev values: bucket_name, instance_type
- **live/prod/ap-south-1/env.hcl** - Prod values: bucket_name, instance_type
- **live/*/terragrunt.hcl** - Connects module to env values

---

## Minimal Config Example

```hcl
# env.hcl
locals {
  environment  = "dev"
  bucket_name  = "my-demo-dev"
  instance_type = "t3.micro"
}

# terragrunt.hcl
include "root" { path = find_in_parent_folders("root.hcl") }
terraform { source = "../../modules/s3" }
inputs = {
  bucket_name = local.environment
}
```

---

## Next Steps

1. Run the Quick Start section above
2. Modify `env.hcl` values and redeploy
3. Check AWS Console to see created resources
4. Read individual files to understand comments

---

**That's it! Simple, minimal, focused on Terragrunt learning. 🚀**
