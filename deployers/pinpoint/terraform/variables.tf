variable "templates" {
  description = "Template deployment payload keyed by logical template id."
  type = map(object({
    template_name = string
    template_type = string
    subject       = string
    html_part     = string
    text_part     = string
    hash          = string
  }))

  validation {
    condition = alltrue([
      for k, t in var.templates : trimspace(t.template_name) != "" && trimspace(t.subject) != ""
    ])
    error_message = "Each template must include non-empty template_name and subject."
  }

  validation {
    condition = alltrue([
      for k, t in var.templates : contains(["EMAIL"], upper(trimspace(t.template_type)))
    ])
    error_message = "Only EMAIL template_type is currently supported."
  }
}
