#!/bin/bash 

#run this script in the location of the BedrockConnect-1.0-SNAPSHOT.jar file

#checks for the latest url for the latest version of the .jar file
URL=$(curl -fs -o/dev/null -w %{redirect_url} https://github.com/Pugmatt/BedrockConnect/releases/latest)

#if missing Bedrockversion.txt, this will create the file
if [[ ! -f Bedrockversion.txt ]]
then
	touch Bedrockversion.txt
else

	#reads Bedrockversion.txt file into veriable #file
	while read line; do file=$line; done < Bedrockversion.txt

	#compares URLS for the curl and $file. If different, this will remove and download the latest version
	if [ "$URL" != $file ]; then
		systemctl stop BedrockConnect.service	#Comment out if you are not running the BedrockConnect as a service
		rm BedrockConnect-1.0-SNAPSHOT.jar
		wget $URL/BedrockConnect-1.0-SNAPSHOT.jar
		systemctl start BedrockConnect.service   #Comment out if you are not running the BedrockConnect as a service
		echo $URL > Bedrockversion.txt
	fi
fi 
