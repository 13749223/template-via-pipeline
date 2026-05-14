# Template Deployment POC

A Node.js 20+ CI/CD template deployment scaffold with provider-isolated deployment architecture.

## Requirements

- Node.js 20+
- npm

## Getting Started

```bash
npm install
npm run lint
npm run format
npm run build
```

## Folder Structure

- `templates/`: source templates
- `partials/`: environment-specific partials
- `scripts/build/`: build + validation + artifact generation pipeline
- `scripts/build/deployers/pinpoint/`: Pinpoint-specific deployment artifact adapter logic
- `dist/`: compiled templates and deployment artifacts
- `deployers/pinpoint/terraform/`: Pinpoint Terraform module implementation

## Architecture

Pipeline stages are isolated by responsibility:

1. Template compilation (partial resolution only)
2. Generic deployment artifact generation (`dist/deployment-artifact.json`)
3. Provider-specific artifact adaptation (Pinpoint tfvars)
4. Provider-specific infrastructure apply (Terraform module)

See `docs/deployment-architecture.md` for migration guidance.

## NPM Scripts

- `npm run build`: build + validate + compile + manifest + generic artifact + provider tfvars
- `npm run lint`: run ESLint checks
- `npm run format`: format supported files with Prettier
