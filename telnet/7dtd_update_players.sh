#!/bin/bash
POSTURL="ENDPOINT_URL_HERE"
APIKEY="API_KEY_HERE"
bash /root/telnet.sh "listplayers lp" players.txt
# extract players string
PLAYERS=$(grep "Total" players.txt)
# if PLAYERS not empty
if [[ ! -z "$PLAYERS" ]]; then
	# format in-game players data
	PLAYERS=$(echo "${PLAYERS//[^a-z0-9 :,]/}")
	# construct JSON
	echo "{\"timestamp\":\"$(date)\",\"data\":\"$PLAYERS\",\"type\":\"players\"}" > players.json
	# upload to S3
	curl -X POST $POSTURL -H"Content-Type:application/json" -H"x-api-key:$APIKEY" -d "@/root/players.json"
fi