#!/bin/bash

FILE="output.js"

echo "const output = {" > $FILE

while read COMMAND; do
	if [ "$COMMAND" = '' ] || echo $COMMAND | grep '^#' -q; then
		continue
	fi
	ACTUAL_COMMAND=$(echo $COMMAND | sed 's/^openstack /microstack.openstack /')
	echo $ACTUAL_COMMAND
	echo "  \"$COMMAND\": \"$($ACTUAL_COMMAND | base64 -w0)\"," >> $FILE
done < commands.txt

echo "}" >> $FILE

