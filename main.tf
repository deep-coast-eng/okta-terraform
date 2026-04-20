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

resource "okta_policy_password" "it_admin_password" {
  name            = "IT Admin Password Policy"
  status          = "ACTIVE"
  description     = "Stronger password requirements for IT administrators"
  groups_included = [okta_group.it_admins.id]

  password_min_length              = 14
  password_min_lowercase           = 1
  password_min_uppercase           = 1
  password_min_number              = 1
  password_min_symbol              = 1
  password_history_count           = 10
  password_max_age_days            = 90
  password_min_age_minutes         = 60
  password_max_lockout_attempts    = 5
  question_recovery		   = "INACTIVE"
  question_min_length		   = 4
}

resource "okta_policy_rule_password" "it_admin_rule" {
  policy_id = okta_policy_password.it_admin_password.id
  name      = "IT Admin Password Rule"
  status    = "ACTIVE"

  password_change    = "ALLOW"
  password_reset     = "ALLOW"
  password_unlock    = "DENY"
}
