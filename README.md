# okta-terraform

Terraform configuration for managing Okta identity infrastructure as code.

## Purpose

Manages Okta groups, policies, and access controls declaratively using the Okta Terraform provider. Treats identity configuration the same way engineering teams treat application infrastructure: version controlled, peer reviewable, and repeatable across environments.

## Why This Matters

Manual Okta administration creates configuration drift. Changes made through the console are invisible to version control, hard to audit, and difficult to reproduce. This repository solves that by defining identity resources in code that can be reviewed, tested, and applied consistently.

## Structure

okta-terraform/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars (not committed, see setup)
├── modules/
│   └── okta-baseline/
├── main.tf
├── variables.tf
├── outputs.tf
└── .gitignore

## Prerequisites

- Terraform >= 1.0
- Okta tenant with API token
- Okta provider ~> 4.0

## Setup

1. Clone the repository
2. Create environments/dev/terraform.tfvars with your credentials:

```hcl
okta_org_name  = "your-okta-org"
okta_api_token = "your-api-token"
```

3. Initialize Terraform:

```bash
terraform init
```

4. Plan changes:

```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
```

5. Apply:

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
```

## Security

Credentials are never committed. The .gitignore excludes all tfvars files and state files. API tokens should be scoped to minimum required permissions.

## Roadmap

- Password policy management
- Group rules and dynamic membership
- Application assignment automation
- SAML app configuration
- Lifecycle management policies
