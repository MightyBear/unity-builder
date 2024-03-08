#!/usr/bin/env bash

NETWORK_ID="93afae59635206ac"

# Install zerotier
curl -s 'https://install.zerotier.com' | bash

# Join Network
for i in {1..5}

do
	OUTPUT=$(sudo zerotier-cli join "$NETWORK_ID")
	echo "Try number $i of 5:"

	if [ $(echo "$OUTPUT" | grep -Ecim1 '200') -eq 1 ]; then
		echo $OUTPUT
		echo "Succesfully connected to zerotier!"
		break;
	else
		echo $OUTPUT
		echo "Waiting for 10sec before retry..."
		sleep 10;
	fi;
done

sudo zerotier-cli status
sudo zerotier-cli info

# Healthcheck on Licensing Server
# curl --connect-timeout 10 'http://10.243.6.149:777/v1/status'
sudo zerotier-cli listnetworks

# Get Floating License
for i in {1..15}

do
	OUTPUT=$(/Applications/Unity/Hub/Editor/2021.3.30f1/Unity.app/Contents/Frameworks/UnityLicensingClient.app/Contents/MacOS/Unity.Licensing.Client --acquire-floating)
	echo "Try number $i of 15:"

	if [ $(echo "$OUTPUT" | grep -Ecim1 '(Created|Renewed)') -eq 1 ]; then
		echo $OUTPUT
		echo "Successfully acquired license!"
		break;
	else
		echo $OUTPUT
		echo "Waiting for 60sec before retry..."
		sleep 60;
	fi;
done

/Applications/Unity/Hub/Editor/2021.3.30f1/Unity.app/Contents/Frameworks/UnityLicensingClient.app/Contents/MacOS --acquire-floating > license.txt
cat license.txt
PARSEDFILE=$(grep -oP '\".*?\"' < license.txt | tr -d '"')
export FLOATING_LICENSE
FLOATING_LICENSE=$(sed -n 2p <<< "$PARSEDFILE")
FLOATING_LICENSE_TIMEOUT=$(sed -n 4p <<< "$PARSEDFILE")

echo "Acquired floating license: \"$FLOATING_LICENSE\" with timeout $FLOATING_LICENSE_TIMEOUT"
