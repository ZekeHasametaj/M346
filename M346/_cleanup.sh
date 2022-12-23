#!/bin/sh

cd workspace

input_bucket_name=`cat config.json | jq '.input_bucket_name' | tr -d '"'`
output_bucket_name=`cat config.json | jq '.output_bucket_name' | tr -d '"'`
lambda_name=`cat config.json | jq '.lambda_name' | tr -d '"'`

echo "> Performing cleanup."

echo "> Deleting input bucket '$input_bucket_name'."
aws s3 rb s3://$input_bucket_name --force 2> /dev/null > /dev/null
echo "> Deleting output bucket '$output_bucket_name'."
aws s3 rb s3://$output_bucket_name --force 2> /dev/null > /dev/null

rm notification_config.json 2> /dev/null > /dev/null

echo "> Deleting lambda function '$lambda_name'."
aws lambda delete-function --function-name $lambda_name 2> /dev/null

cd ..
echo "> Cleanup performed successfully."
