# Stage 1: Build Stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy and install backend dependencies
COPY package*.json ./
RUN npm install

# Copy all backend files
COPY . .

# Build frontend
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
RUN npm run build

# Stage 2: Runtime Stage
FROM node:18-alpine

WORKDIR /app

# Copy backend files
COPY --from=builder /app .

# Serve frontend using the backend
WORKDIR /app
EXPOSE 3000

CMD ["npm", "start"]
