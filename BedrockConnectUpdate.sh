#!/bin/bash 
URL=$(curl -fs -o/dev/null -w %{redirect_url} https://github.com/Pugmatt/BedrockConnect/releases/latest)

while read line; do file=$line; done < Bedrockversion.txt


if [ "$URL" != $file ]; then
    systemctl stop BedrockConnect.service
	rm BedrockConnect-1.0-SNAPSHOT.jar
	wget $URL/BedrockConnect-1.0-SNAPSHOT.jar
	sudo systemctl start BedrockConnect.service
	echo $URL > Bedrockversion.txt
fi
