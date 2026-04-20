terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"

  cloud {
    organization = "deep-coast-eng"
    workspaces {
      name = "okta-dev"
    }
  }
}

provider "okta" {
  org_name  = var.okta_org_name
  base_url  = "okta.com"
  api_token = var.okta_api_token
}

resource "okta_group" "engineering" {
  name        = "engineering"
  description = "Engineering team group managed via Terraform"
}

resource "okta_group" "it_admins" {
  name        = "it-admins"
  description = "IT administrators group managed via Terraform"
}
