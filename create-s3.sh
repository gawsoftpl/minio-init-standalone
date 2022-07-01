#!/bin/bash
# Set endpoint
mc alias set s3 $ENDPOINT $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

## Create user
mc admin user add s3 $access_key $secret_key

# Create buckets
for i in {1..1000}; do
  var=INITIAL_BUCKET_NAME_$i
  value=${!var}
  if [ ${#value} -gt 0 ]; then
    echo "Creating bucket ${value}"
    mc mb s3 ${value}
  fi
done
