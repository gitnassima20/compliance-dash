# Frontend

React frontend for the NIST-800 Compliance Dashboard.

- TypeScript, React, Vite

## Setup

1. `npm install`
2. Configure `.env` (see `.env.example`)
3. `npm run dev` (for developement)
4. `npm run build` (for production build)

## Containerization

The React frontend can be bundled into a small container (~110 MB compressed) and served via a lightweight static server.

### Build the image

```bash
# Podman
podman build -f frontend/Dockerfile -t compliance-dash-frontend .
```

### Run the container in detached mode

```bash
podman run -d --name compliance-dash-frontend -p 3000:3000 compliance-dash-frontend
```

Open `http://localhost:3000` in your browser.
