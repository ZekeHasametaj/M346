#!/bin/sh

cd workspace

input_bucket_name=`cat config.json | jq '.input_bucket_name' | tr -d '"'`
output_bucket_name=`cat config.json | jq '.output_bucket_name' | tr -d '"'`
lambda_name=`cat config.json | jq '.lambda_name' | tr -d '"'`
statement_id=`cat config.json | jq '.statement_id' | tr -d '"'`

echo "> Getting LabRole ARN..."
arn=$(aws iam get-role --role-name LabRole | grep Arn | awk -F '"' '{print $4}')
echo "> Retrieved: $arn"

echo "> Creating input and output buckets..."
aws s3 mb s3://$input_bucket_name > /dev/null
aws s3 mb s3://$output_bucket_name > /dev/null

echo "> Preparing lambda function..."
zip func.zip func.js > /dev/null

echo "> Creating lambda function..."
aws lambda create-function --function-name $lambda_name --zip-file fileb://func.zip --handler func.handler --runtime nodejs16.x --role $arn > /dev/null

echo "> Setting up notification configuration..."
lambda_arn=$(aws lambda get-function --function-name $lambda_name | grep FunctionArn | awk -F '"' '{print $4}')

tmp=$(mktemp)
jq --arg a "$lambda_arn" '.LambdaFunctionConfigurations[0].LambdaFunctionArn = $a' notification_config_template.json > "$tmp" && mv "$tmp" notification_config.json
tmp=$(mktemp)
jq --arg a "$lambda_name-notification" '.LambdaFunctionConfigurations[0].Id = $a' notification_config.json > "$tmp" && mv "$tmp" notification_config.json
echo "> Inserted lambda ARN & id."

echo "> Creating notification..."
aws s3api put-bucket-notification-configuration --bucket $input_bucket_name --notification-configuration file://./notification_config.json

cd ..

echo "> Finished setup."