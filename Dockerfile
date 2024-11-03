# Step 1: Use an official Node.js runtime as a parent image
FROM node:14 AS build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application code to the working directory
COPY . .

# Step 6: Build the React app for production
RUN npm run build

# Step 7: Use an official Nginx image to serve the built app
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Step 8: Expose port 80
EXPOSE 80

# Step 9: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]