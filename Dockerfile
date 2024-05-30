FROM alpine:latest

# Install necessary tools
RUN apk add --no-cache unzip ca-certificates curl

# Fetch the latest PocketBase version
ARG PB_VERSION
RUN PB_VERSION=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    echo "PB_VERSION=${PB_VERSION}" > /etc/pb_version

# Download and unzip PocketBase
RUN PB_VERSION=$(cat /etc/pb_version | cut -d '=' -f 2) && \
    curl -L -o /tmp/pb.zip https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip && \
    unzip /tmp/pb.zip -d /pb/

# env
COPY .env .
RUN source .env

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
