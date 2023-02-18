#!/usr/bin/env bash

WEB_APP_S3_OUTPUT_KEY="WebAppS3BucketName"
CLOUDFRONT_DIST_OUTPUT_KEY="CloudFrontDistributionId"
WEB_APP_DOMAIN_OUTPUT_KEY="WebAppDomain"

get_web_app_s3_bucket_name() {
    aws cloudformation describe-stacks \
        --stack-name thor-spike-react-s3-cloudfront \
        --no-paginate \
        --no-cli-pager \
        --output text \
        --query "Stacks[0].Outputs[?OutputKey=='$WEB_APP_S3_OUTPUT_KEY'].OutputValue"
}

get_cloudfront_distribution_id() {
    aws cloudformation describe-stacks \
        --stack-name thor-spike-react-s3-cloudfront \
        --no-paginate \
        --no-cli-pager \
        --output text \
        --query "Stacks[0].Outputs[?OutputKey=='$CLOUDFRONT_DIST_OUTPUT_KEY'].OutputValue"
}

get_web_app_domain() {
    aws cloudformation describe-stacks \
        --stack-name thor-spike-react-s3-cloudfront \
        --no-paginate \
        --no-cli-pager \
        --output text \
        --query "Stacks[0].Outputs[?OutputKey=='$WEB_APP_DOMAIN_OUTPUT_KEY'].OutputValue"
}

# Upload files
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SOURCE_DIR="$SCRIPT_DIR/../build"
S3_BUCKET=$(get_web_app_s3_bucket_name)
echo "Uploading files from $SOURCE_DIR to s3://$S3_BUCKET"
aws s3 sync $SOURCE_DIR s3://$S3_BUCKET

# Clear CloudFront cache
CLOUDFRONT_DIST_ID=$(get_cloudfront_distribution_id)
echo "Clearing CloudFront cache for distribution id: $CLOUDFRONT_DIST_ID"
aws cloudfront create-invalidation \
    --distribution-id $CLOUDFRONT_DIST_ID \
    --no-paginate \
    --no-cli-pager \
    --paths "/*"

# Information
WEB_APP_DOMAIN=$(get_web_app_domain)
echo "Deployment done!"
echo "Visit https://$WEB_APP_DOMAIN"