#!/usr/bin/env bash

# Run in ACTIVATE_LICENSE_PATH directory
echo "Changing to \"$ACTIVATE_LICENSE_PATH\" directory."
pushd "$ACTIVATE_LICENSE_PATH"

# MBG return method
echo "Returning floating license: \"$FLOATING_LICENSE\"" 
/Applications/Unity/Hub/Editor/2021.3.30f1/Unity.app/Contents/Frameworks/UnityLicensingClient.app/Contents/MacOS/Unity.Licensing.Client  --return-floating "$FLOATING_LICENSE"

# GameCI return method
# /Applications/Unity/Hub/Editor/$UNITY_VERSION/Unity.app/Contents/MacOS/Unity \
#   -logFile /dev/stdout \
#   -batchmode \
#   -nographics \
#   -quit \
#   -username "$UNITY_EMAIL" \
#   -password "$UNITY_PASSWORD" \
#   -returnlicense \
#   -projectPath "$ACTIVATE_LICENSE_PATH"

# Return to previous working directory
popd
