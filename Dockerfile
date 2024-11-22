# Use a Node.js image as the base
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json for the backend
COPY package*.json ./

# Install backend dependencies
RUN npm install

# Copy the entire backend code to the container
COPY . .

# Set the working directory to the client (frontend) folder
WORKDIR /app/client

# Copy package.json and package-lock.json for the frontend
COPY client/package*.json ./

# Install frontend dependencies
RUN npm install

# Build the frontend
RUN npm run build

# Set the working directory back to the root folder
WORKDIR /app

# Expose the port on which your application will run
EXPOSE 3000

# Start the backend server
CMD ["npm", "start"]
