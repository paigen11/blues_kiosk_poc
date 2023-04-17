#!/bin/bash

# Function to download a zip file from the notehub
function download {
	REMOTE_FILENAME=$1
	LOCAL_FILENAME=$2
	CHUNKLEN=8192

	# Loop over all chunks
	let OFFSET=0
	while [ true ]
	do

		# Download a chunk
		req '-fast {"req":"web.get","route":"'$PROXY'","name":"'$REMOTE_FILENAME'","content":"application/zip","offset":'$OFFSET',"max":'$CHUNKLEN'}'

		# Extract payload, appending it to the file
		PAYLOAD=`echo $RSP | jq -r .payload | cut -d "," -f 2 | base64 --decode >>$LOCAL_FILENAME`

		# An I/O error will come back with no total
		TOTAL=`echo $RSP | jq -r .total`
		if [[ "$TOTAL" == "null" ]]; then
		    echo "retrying..."
		else
		    let OFFSET+=$CHUNKLEN
		    if [[ "$OFFSET" -ge "$TOTAL" ]]; then break; fi
		    echo "$OFFSET/$TOTAL downloaded"
		fi

	done
}