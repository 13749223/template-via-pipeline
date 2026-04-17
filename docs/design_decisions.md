# Design Decisions & Future Enhancements

## Phase 1 Scope Decision

For this POC, templates will be **kept unchanged** from their current format.

### Rationale

* The primary goal of this POC is to validate:

  * Git-based template management
  * CI/CD pipeline integration
  * Deployment via Terraform (or equivalent)

* Modifying template structure (e.g., introducing placeholders, templating logic, or normalization) would:

  * Increase scope unnecessarily
  * Introduce additional variables that are not required for validating the DevOps flow
  * Make it harder to compare with existing manually managed templates

---

## Current Approach

* Templates will be stored in the repository **as-is**
* Environment-specific differences (e.g., test banners, image URLs) will be handled by:

  * Transformation logic (existing script logic reused/refactored)
  * Not by modifying template source files

---

## Known Limitations (Accepted for POC)

* Templates contain environment-specific values (e.g., URLs, test content)
* Transformation relies on regex/string manipulation
* No template abstraction (no placeholders like `{{env}}`, etc.)
* Potential duplication across environments

---

## Future Enhancements (Post-POC)

### 1. Environment-Agnostic Templates

Move towards templates that use placeholders:

* Example:

  * `{{base_url}}` instead of hardcoded domain
  * Conditional blocks for test banners

---

### 2. Introduce Template Rendering Layer

* Use a templating engine (e.g., Jinja2 or similar)
* Replace regex-based transformation with structured rendering

---

### 3. Remove Transformation Hacks

* Deprecate parts of the current sync script that:

  * Strip test messages
  * Modify HTML using regex
* Replace with deterministic rendering logic

---

### 4. Standardize Template Format

* Enforce consistent structure across:

  * Email
  * SMS
  * Voice

---

### 5. Validation Layer

* Add checks for:

  * Missing placeholders
  * Invalid HTML
  * Broken links

---

## Long-Term Vision

```text
Templates (Clean, Env-Agnostic)
        ↓
Rendering Layer (Deterministic)
        ↓
Deployment Layer (Replaceable)
        ↓
Notification Service (Pinpoint or successor)
```

---

## Summary

This POC intentionally prioritizes:

* Deployment automation
* Version control
* Pipeline integration

over:

* Template refactoring
* Content standardization

These will be addressed in subsequent iterations.
