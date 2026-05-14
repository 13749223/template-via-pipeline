output "email_template_ids" {
  description = "AWS Pinpoint email template resource IDs by logical template key."
  value       = { for key, r in aws_pinpoint_email_template.email : key => r.id }
}

output "email_template_names" {
  description = "Created/updated Pinpoint template names by logical template key."
  value       = { for key, r in aws_pinpoint_email_template.email : key => r.template_name }
}

output "deployed_template_hashes" {
  description = "Informational artifact hashes passed into this module by logical template key."
  value       = { for key, t in local.email_templates : key => t.hash }
}
