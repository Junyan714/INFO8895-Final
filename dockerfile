# Use a lightweight Node.js image as the base image
FROM node:alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React application
RUN npm run build

# Use a lightweight web server to serve the application
FROM nginx:alpine

# Copy the built files from the previous stage to the nginx directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to make the application accessible
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]
