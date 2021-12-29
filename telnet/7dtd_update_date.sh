#!/bin/bash
POSTURL="ENDPOINT_URL_HERE"
APIKEY="API_KEY_HERE"
bash /root/telnet.sh "gettime gt" date.txt
# extract day + time string
DATETIME=$(grep "Day" date.txt)
# if DATETIME not empty
if [[ ! -z "$DATETIME" ]]; then
	# format in-game datetime
	DATETIME=$(echo "${DATETIME//[^a-z0-9 :,]/}")
	# construct JSON
	echo "{\"timestamp\":\"$(date)\",\"data\":\"$DATETIME\",\"type\":\"date\"}" > /root/date.json
	# upload to S3
	curl -X POST $POSTURL -H"Content-Type:application/json" -H"x-api-key:$APIKEY" -d "@/root/date.json"
fi