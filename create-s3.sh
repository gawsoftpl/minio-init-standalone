#!/bin/bash

# Set endpoint
mc alias set s3 $ENDPOINT $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

lifecycle_days () {
# If set lifecycle

mc ilm import s3/$1 <<EOF
  {
      "Rules": [
          {
              "Expiration": {
                  "Days": $2
              },
              "ID": "OldFiles",
              "Filter": {
                  "Prefix": "$3"
              },
              "Status": "Enabled"
          }
      ]
  }
EOF

}


## Create user
mc admin user add s3 $access_key $secret_key

if [ $? -gt 0 ];
then
  echo "Error with create account"
  exit 1
fi

# Set Policy readwrite
mc admin policy set s3 $POLICY_NAME user=$access_key

# Create buckets
for i in {1..1000}; do
  var=INITIAL_BUCKET_NAME_$i
  value=${!var}
  if [ ${#value} -gt 0 ]; then
    echo "Creating bucket ${value}"
    mc mb s3/${value}

    if [ $? -gt 0 ];
    then
      echo "Error with create bucket"
      exit 1
    fi

    if [ ${#BUCKET_LIFECYCLE_DAYS} -gt 0 ];
    then
      lifecycle_days ${value} ${BUCKET_LIFECYCLE_DAYS} ${BUCKET_LIFECYCLE_PREFIX} 
    fi
    
  fi
done



exit 0
