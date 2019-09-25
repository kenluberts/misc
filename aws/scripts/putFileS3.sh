#!/bin/bash
objectName="<full path of file on bucket>"
file="<local file to upload>"
bucket="<bucket name>"
resource="/${bucket}/${objectName}"
contentType="text/plain"
dateValue=`date -R`

stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"

s3Key="XXXXXXXXXXXXXXXXXXXX"
s3Secret="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`

curl -v -i -X PUT -T "${file}" \
          -H "Host: ${bucket}.s3.amazonaws.com" \
          -H "Date: ${dateValue}" \
          -H "Content-Type: ${contentType}" \
          -H "Authorization: AWS ${s3Key}:${signature}" \
          https://${bucket}.s3.amazonaws.com/${objectName}

