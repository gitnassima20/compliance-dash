# Node.js 20 backend container for Compliance Dashboard
# Multi-stage build: compile TypeScript, run on alpine

###########
# Build   #
###########
FROM node:20 AS build
WORKDIR /app

# Install dependencies first (leverages Docker cache)
# Copy backend package files when build context is project root
COPY backend/package*.json ./
# Install ALL dependencies (dev + prod) for compilation
RUN npm ci

# Copy application source and compile TypeScript
# Copy backend source code
COPY backend .
# Compile TypeScript
# Compile TypeScript to ./dist
RUN npx tsc --rootDir src --outDir dist
# Remove devDependencies to slim the image
RUN npm prune --omit=dev

############
# Runtime  #
############
FROM node:20-alpine AS runtime
WORKDIR /app

# Copy compiled output and production node_modules
COPY --from=build /app /app

ENV NODE_ENV=production
EXPOSE 4000

CMD ["node", "dist/index.js"]
