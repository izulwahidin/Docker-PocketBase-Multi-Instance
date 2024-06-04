#!/bin/bash

# Run the generate.sh script (assuming it's in the same directory)
./generate.sh

# Check if docker-compose is already running
if docker-compose ps &> /dev/null; then
  echo "Stopping existing docker-compose services..."
  docker-compose down
fi

# Build and start the docker-compose services
docker-compose up --build -d

echo "Successfully started docker-compose services in detached mode."
