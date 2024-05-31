#!/bin/bash

# Load environment variables from .env file
source .env

# Initialize docker-compose.yml content
compose_file="version: \"3.8\"
services:
"

# Initialize Caddyfile content
caddy_file=":80 {
  log {
      level DEBUG
  }
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
      - ./pocketbase/${pb_name}:/pocketbase/${pb_name}
    networks:
      - pbmi_net
"

  # Add reverse proxy rule to Caddyfile
  caddy_file+="  reverse_proxy /${pb_name}* :${pb_port}
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
      - ./caddy/Caddyfile.conf:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
    networks:
      - pbmi_net

volumes:
  caddy_data:
  caddy_config:

networks:
  pbmi_net:
"

# Finalize Caddyfile content
caddy_file+="
  route / {
      respond \"Hello, World!\" 200
  }

  handle_errors {
    respond \"Fuck!\" 500
  }
}
"

# Write the generated content to the respective files
echo "$compose_file" > ./docker-compose.yml
echo "$caddy_file" > ./caddy/Caddyfile.conf

echo "docker-compose.yml and Caddyfile have been generated."
