# Local AI Stack with n8n Integration

This project sets up a comprehensive local AI development environment with n8n automation, Flowise, Qdrant vector database, and other services, all configured for seamless integration.

## Overview

The Local AI Stack is a Docker-based solution that combines various AI services and tools:

- **n8n**: Workflow automation platform for connecting various services
- **Flowise**: Low-code platform for building AI workflows
- **Qdrant**: Vector database for semantic search and similarity matching
- **Caddy**: Web server with automatic HTTPS for local development
- **Supabase**: Optional open-source Firebase alternative
- **Redis (Valkey)**: In-memory database for caching
- **Postgres**: Relational database

## Prerequisites

- Docker and Docker Compose
- Python 3.6+
- Git

## Getting Started

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd local-ai-packaged
   ```

2. Create a `.env` file in the root directory with the following variables:
   ```
   # Required environment variables
   POSTGRES_PASSWORD=your_secure_password
   N8N_ENCRYPTION_KEY=your_secure_key
   N8N_USER_MANAGEMENT_JWT_SECRET=your_secure_jwt_secret
   
   # Optional hostnames for Caddy (default to localhost with ports)
   N8N_HOSTNAME=:8001
   FLOWISE_HOSTNAME=:8003
   SUPABASE_HOSTNAME=:8005
   WEBUI_HOSTNAME=:8002
   LANGFUSE_HOSTNAME=:8004
   OLLAMA_HOSTNAME=:8006
   SEARXNG_HOSTNAME=:8007
   
   # For production with real domains, set real email
   LETSENCRYPT_EMAIL=your@email.com
   ```

3. Start the services:
   ```bash
   python start_services.py
   ```
   
   Or use the newer version:
   ```bash
   python start_services_new.py
   ```

## Services

| Service    | Default URL              | Description                        |
|------------|--------------------------|-----------------------------------|
| n8n        | http://localhost:8001    | Workflow automation platform       |
| Flowise    | http://localhost:8003    | AI workflow builder               |
| Supabase   | http://localhost:8005    | Open source Firebase alternative  |
| Qdrant     | http://localhost:6333    | Vector database                   |
| Postgres   | localhost:5433           | Database (not exposed via Caddy)   |

## Python Integration

The project includes `n8n_pipe.py` for integrating n8n with Python applications:

```python
from n8n_pipe import Pipe

# Initialize the pipe
pipe = Pipe()
pipe.valves.n8n_url = "your_n8n_webhook_url"
pipe.valves.n8n_bearer_token = "your_token"

# Use the pipe in your application
response = await pipe(user_input)
```

## Configuration

### Customizing Caddy

Edit the `Caddyfile` to add or modify services. The default configuration proxies requests to various local services.

### Docker Compose

The `docker-compose.yml` file defines all services. You can modify resource limits, add volumes, or configure environment variables as needed.

## Development

For local development, you can access:

- n8n dashboard at [http://localhost:8001](http://localhost:8001)
- Flowise designer at [http://localhost:8003](http://localhost:8003)
- Qdrant dashboard at [http://localhost:6333/dashboard](http://localhost:6333/dashboard)

## Troubleshooting

If you encounter issues:

1. Check Docker container logs:
   ```bash
   docker logs n8n
   docker logs flowise
   ```

2. Make sure all required environment variables are set in the `.env` file.

3. If Supabase fails to start, try running the start script with the `--skip-supabase` flag:
   ```bash
   python start_services.py --skip-supabase
   ```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- n8n: [https://n8n.io/](https://n8n.io/)
- Flowise: [https://github.com/FlowiseAI/Flowise](https://github.com/FlowiseAI/Flowise)
- Qdrant: [https://qdrant.tech/](https://qdrant.tech/)
- Supabase: [https://supabase.com/](https://supabase.com/)