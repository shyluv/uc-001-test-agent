FROM --platform=linux/arm64 jnj-docker.artifactrepo.jnj.com/python:3.12.0-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV AWS_REGION=us-east-1 \
    AWS_DEFAULT_REGION=us-east-1 \
    PYTHONUNBUFFERED=1 \
    DOCKER_CONTAINER=1

# Copy requirements and install dependencies
COPY _scm_container/agent/requirements.txt .

# Install dependencies and verify ARM64 compatibility
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl --version && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Architecture verification
RUN echo "Building for architecture: $(uname -m)"

# Create entrypoint script with debug logging
RUN echo '#!/bin/bash' > /usr/local/bin/entrypoint.sh && \
    echo 'set -x' >> /usr/local/bin/entrypoint.sh && \
    echo 'echo "=== Container Starting ==="' >> /usr/local/bin/entrypoint.sh && \
    echo 'echo "Running on: $(uname -m)"' >> /usr/local/bin/entrypoint.sh && \
    echo 'echo "Architecture: $(arch)"' >> /usr/local/bin/entrypoint.sh && \
    echo 'echo "Python version: $(python --version)"' >> /usr/local/bin/entrypoint.sh && \
    echo 'echo "Starting AgentCore application..."' >> /usr/local/bin/entrypoint.sh && \
    echo 'exec opentelemetry-instrument python3 -m main' >> /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# Copy application code
COPY _scm_container/agent/main.py _scm_container/agent/parse_response.py _scm_container/agent/__init__.py ./

# Create non-root user and set ownership
RUN useradd -m -u 1000 bedrock_agentcore && \
    chown -R bedrock_agentcore:bedrock_agentcore /app

USER bedrock_agentcore

# Expose ports for AgentCore Runtime
EXPOSE 8080 8000

# Health check with proper timing for Strands initialization
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/ping', timeout=2)" || exit 1

# Run with OpenTelemetry instrumentation
CMD ["/usr/local/bin/entrypoint.sh"]
