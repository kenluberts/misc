#!/bin/sh 
outputFile="<output file name>"
amzFile="<path to file on bucket>"
region="us-east-1"
bucket="<bucket name>"
resource="/${bucket}/${amzFile}"
contentType="application/octet-stream"
dateValue=`TZ=GMT date -R`

# You can leave our "TZ=GMT" if your system is already GMT (but don't have to)
stringToSign="GET\n\n${contentType}\n${dateValue}\n${resource}"

s3Key="XXXXXXXXXXXXXXXXXXXX"
s3Secret="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
echo $signature

curl -H "Host: ${bucket}.amazonaws.com" \
     -H "Date: ${dateValue}" \
     -H "Content-Type: ${contentType}" \
     -H "Authorization: AWS ${s3Key}:${signature}" \
     https://${bucket}.s3.amazonaws.com/${bucket}/${amzFile} -o $outputFile
