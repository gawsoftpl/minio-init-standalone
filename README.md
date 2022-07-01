# minio-init-standalone
Initial script for create user and bucket for standalone minio s3 server

# Requered ENV
```
ENDPOINT=http://s3:9000
MINIO_ROOT_USER=minio
MINIO_ROOT_PASSWORD=minio123
```

# For create user
```
access_key=abcfdsf
secret_key=dfgdfgdf
```

# For create bucket
```
INITIAL_BUCKET_NAME_1=abc2
INITIAL_BUCKET_NAME_2=abcd
INITIAL_BUCKET_NAME_3=ab
etc up to 1000
```

# Execute
```sh
/bin/bash create-s3.sh
```