# React frontend container for Compliance Dashboard
# Multi-stage build: compile optimized static files, then serve them with a tiny runtime image.

############
# Build    #
############
FROM node:20 AS build
WORKDIR /app

# Install deps (leverages cache). Assumes build context is the `frontend` directory.
COPY frontend/package*.json ./
RUN npm ci --omit=dev

# Copy source and build
COPY frontend .
RUN npm run build

############
# Runtime  #
############
FROM node:20-alpine AS runtime
WORKDIR /app

# Minimal static file server
RUN npm install -g serve@14

# Copy compiled assets from build stage
COPY --from=build /app/build ./build

ENV NODE_ENV=production
EXPOSE 3000

# Serve the static site on port 3000
CMD ["serve", "-s", "build", "-l", "3000"]
