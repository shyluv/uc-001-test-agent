# =========================================
# Bedrock AgentCore Module Configuration
# =========================================

module "bedrock_agentcore" {
  source = "git::https://sourcecode.jnj.com/scm/asx-iacx/terraform-aws-agentcore?ref=feature/jjev-1220-auth"

  agent_name        = "test-agent"
  agent_description = "Test agent for validation"
  environment       = "dev"
  deployment_method = "container"

  idle_session_timeout = "1800"
  max_lifetime         = "3600"
  log_level            = "INFO"

  # Container Specific
  ecr_name  = "bedrock-agentcore-test-agent-dev"
  image_tag = "latest"

  # Network Configuration
  subnet_ids         = ["subnet-01a414291c62ed6f8"]
  security_group_ids = ["sg-04fdc966af0ee63b0"]

  # Entra ID JWT Inbound Authentication
  entra_tenant_id = "3ac94b33-9135-4821-9502-eafda6592a35"
  entra_client_id = "db4449ed-27ac-4548-a715-0fe7a24932ac"

  # Allow Authorization header propagation
  request_header_allowlist = [
    "Authorization",
    "X-Amzn-Bedrock-AgentCore-Runtime-Custom-H1",
  ]

  # Tags
  application      = "jjev"
  use_case_id      = "uc-001"
  xena_asx_project = "ASX-JJEV"
}
