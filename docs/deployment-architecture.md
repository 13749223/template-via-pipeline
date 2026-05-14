# Deployment Architecture

## Separation of Concerns

The pipeline is split into three layers:

1. Template compilation
- Implemented in `scripts/build/build.js`.
- Resolves template partials and preserves runtime handlebars expressions.
- Provider-agnostic.

2. Deployment artifact generation
- Implemented in `scripts/build/hash.js` and `scripts/build/generate-deployment-artifact.js`.
- Produces generic outputs in `dist/`:
  - `manifest.json`
  - `deployment-artifact.json`
- Provider-agnostic contract consumed by deployers.

3. Provider-specific deployment
- Pinpoint adapter logic: `scripts/build/deployers/pinpoint/generate-tfvars.js`.
- Pinpoint Terraform module: `deployers/pinpoint/terraform/`.
- Provider-specific and replaceable.

## What Changes to Migrate Away From Pinpoint

Only provider layer changes are required:

- Replace `scripts/build/deployers/pinpoint/generate-tfvars.js` with a new provider adapter.
- Replace `deployers/pinpoint/terraform/` with a new provider module.
- Update CI workflow Terraform working directory and provider adapter invocation.

## What Remains Reusable

These remain unchanged during provider migration:

- Template authoring format under `templates/` and `partials/`.
- Validation (`scripts/build/validate.js`).
- Partial-only compilation (`scripts/build/build.js`).
- Hash generation (`scripts/build/hash.js`).
- Generic deployment contract (`dist/deployment-artifact.json`).

## Migration Principle

Keep all provider assumptions isolated under `deployers/<provider>/` so deprecating Pinpoint requires minimal changes outside that folder.
