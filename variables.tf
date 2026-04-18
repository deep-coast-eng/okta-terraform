variable "okta_org_name" {
  description = "Okta org name, the part before .okta.com"
  type        = string
}

variable "okta_api_token" {
  description = "Okta API token"
  type        = string
  sensitive   = true
}
