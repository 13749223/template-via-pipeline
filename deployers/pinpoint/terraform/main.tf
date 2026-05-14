terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

locals {
  # Keep a provider-agnostic internal shape so this module can later swap
  # Pinpoint-specific resources with minimal input/interface changes.
  deployable_templates = var.templates

  email_templates = {
    for key, template in local.deployable_templates : key => template
    if upper(template.template_type) == "EMAIL"
  }
}

resource "aws_pinpoint_email_template" "email" {
  for_each = local.email_templates

  template_name = each.value.template_name

  email_template {
    subject   = each.value.subject
    html_part = each.value.html_part
    text_part = each.value.text_part
  }
}
