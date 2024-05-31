#!/bin/bash

# Load environment variables from .env file
source .env

# Initialize docker-compose.yml content
compose_file="version: \"3.8\"
services:
"

# Initialize Caddyfile content
caddy_file=":80 {
"

# Loop through the environment variables
for var in $(compgen -A variable | grep ^PB); do
  pb_name=$(echo ${!var} | cut -d':' -f1)
  pb_port=$(echo ${!var} | cut -d':' -f2)
  
  # Add service to docker-compose.yml
  compose_file+="  ${pb_name}:
    build: .
    container_name: ${pb_name}
    environment:
      - DATA_DIR=/pocketbase/${pb_name}
      - HTTP_PORT=${pb_port}
    ports:
      - \"${pb_port}:${pb_port}\"
    restart: always
    volumes:
      - \$PWD/pocketbase/${pb_name}:/pocketbase/${pb_name}
"

  # Add reverse proxy rule to Caddyfile
  caddy_file+="    handle /${pb_name}* {
        reverse_proxy localhost:${pb_port}
    }
"
done

# Finalize docker-compose.yml content with caddy service
compose_file+="
  caddy:
    image: caddy:latest
    restart: always
    cap_add:
      - NET_ADMIN
    ports:
      - \"80:80\"
      - \"443:443\"
      - \"443:443/udp\"
    volumes:
      - \$PWD/caddy/Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
    external: true
  caddy_config:
"

# Finalize Caddyfile content
caddy_file+="
    handle {
        respond \"Hello, PocketBase Multi Instance!\"
    }

    handle_errors {
        respond \"Oops! Something went wrong.\" 500
    }
}
"

# Write the generated content to the respective files
echo "$compose_file" > ./docker-compose.yml
echo "$caddy_file" > ./caddy/Caddyfile

echo "docker-compose.yml and Caddyfile have been generated."
