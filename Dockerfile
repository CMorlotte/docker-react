# Initial docker image. This uses node. It is tagged as "builder"
FROM node:alpine as build_phase

# This creates a dir inside the container
WORKDIR '/usr/react-app'

# Copies package.json from local dir to WORKDIR
COPY package.json .

# Runs a command in container, installs npm
RUN npm install

# Copies all files in local to WORKDIR root
COPY . .

# Command to run when container starts
RUN npm run build

# Deploy phase, gets image for nginx
FROM nginx

# Copies from first phase "builder"
COPY --from=build_phase /usr/react-app/build /usr/share/nginx/html
