# Backend

Node.js backend for the NIST-800 Compliance Dashboard.

- TypeScript, Express, Prisma ORM
- Integrates AWS SDK v3 and OpenAI API

## Setup

1. `npm install`
2. Configure `.env` (see `.env.example`)
3. `npx prisma migrate dev`
4. `npm run dev`

## Containerization

Package the backend into a lightweight container, about 270MB using Podman(docker alternative)

### Build the image

```bash
# Podman
podman build -f backend/Dockerfile -t compliance-dash-backend .
```

### Run the container in detached mode

```bash
podman run -d --name compliance-dash-backend -p 4000:4000 compliance-dash-backend
```

