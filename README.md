# uc-001-test-agent

Test agent for validation

## Agent Details

- **Application ID**: APP-12345
- **Use Case ID**: uc-001
- **Environment**: dev
- **Deployment Method**: container
- **Project**: ASX-JJEV

## Structure

```
_scm_container/agent/   — Agent source code + Dockerfile
_scm_iac/               — Terraform infrastructure
_scm_jenkins/           — CI/CD pipeline config
_scm_config/            — Environment-specific tfvars
```

## Infrastructure

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Deployment

This agent is deployed via JPM Pipeline. Push to trigger automated deployment.
