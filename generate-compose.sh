#!/bin/bash

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Error: .env file not found."
    exit 1
fi

# Initialize docker-compose.yml
echo "version: \"3.8\"
services:" > docker-compose.yml

# Parse .env file using awk and generate docker-compose.yml
awk -F'=' '/^PB[0-9]+/{split($2, service, ":"); printf "  %s:\n    build: .\n    container_name: %s\n    environment:\n      - DATA_DIR=/pocketbase/%s\n      - HTTP_PORT=%s\n    ports:\n      - \"%s:%s\"\n    volumes:\n      - /pocketbase/%s:/pocketbase/%s\n\n", service[1]service[2], service[1]service[2], service[1]service[2], service[2], service[2], service[2], service[1]service[2], service[1]service[2]}' .env | sed 's/"//g' >> docker-compose.yml

echo "docker-compose.yml has been generated successfully."
