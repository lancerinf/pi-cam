#!/bin/bash

# This script is run on a cron(0 * * * *) schedule, it takes a picture from the default system camera, uploads it to 1 or more S3 buckets and removes the local copy.


DATE=$(date +"%Y-%m-%d_%H%M")
FILENAME="${DATE}.jpg"

PROJECT="chili_0"
S3_DESTINATION_LIVE="s3://cam-fede-rocks-live/captures/${PROJECT}"
S3_DESTINATION_LT="s3://cam-fede-rocks-long-term/${PROJECT}"


# Take picture
fswebcam --gmt \
 --frames 20 \
 --skip 10 \
 --delay 3 \
 --resolution "1280x720" \
 --line-colour "#FF000000" \
 --banner-colour "#FF000000" \
 --text-colour "#FFFF00" \
 --font "sans:20" \
 "${FILENAME}"


# Upload to S3
echo "Uploading ${FILENAME} to ${S3_DESTINATION_LIVE}"
aws s3 cp "${FILENAME}" "${S3_DESTINATION_LIVE}/latest.jpg"

echo "Uploading ${FILENAME} to ${S3_DESTINATION_LT}"
aws s3 cp "${FILENAME}" "${S3_DESTINATION_LT}/${FILENAME}"


# Remove local file
echo "Deleting local file ${FILENAME}"
rm "${FILENAME}"
