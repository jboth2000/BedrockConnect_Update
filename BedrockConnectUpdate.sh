#!/bin/bash
URL=$(curl -fs -o/dev/null -w %{redirect_url} https://github.com/Pugmatt/BedrockConnect/releases/latest)

test -z "$URL"  && exit 1;

#test if file Bedrockversion.txt is missing, this will create the file with url loaction
test ! -f Bedrockversion.txt && touch Bedrockversion.txt && echo "https://github.com/Pugmatt/BedrockConnect/releases/tag/old" > Bedrockversion.txt

#reads Bedrockversion.txt file into veriable #file
while read line; do file=$line; done < Bedrockversion.txt

#compares URLS for the curl and $file. If different, this will remove and download the latest version
if [ "$URL" != $file ]; then
        systemctl stop BedrockConnect.service   #Comment out if you are not running the BedrockConnect as a service
        rm BedrockConnect-1.0-SNAPSHOT.jar
        wget $URL/BedrockConnect-1.0-SNAPSHOT.jar
        systemctl start BedrockConnect.service   #Comment out if you are not running the BedrockConnect as a service
        echo $URL > Bedrockversion.txt
fi
