#!/bin/sh

# Default values
DATA_DIR=${DATA_DIR:-"/pb_data"}
HTTP_PORT=${HTTP_PORT:-8090}

# Run PocketBase
/pb/pocketbase serve --dir="${DATA_DIR}" --http="0.0.0.0:${HTTP_PORT}"
