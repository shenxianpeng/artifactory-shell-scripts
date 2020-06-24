#!/bin/bash
# replace username with your artifactory username
# replace password with your artifactory password
# replace START_TIME for minimum creation time in milliseconds of artifacts  (example 1591585471181 for Mon, Jun  8, 2020)
# replace END_TIME for maximum creation time in milliseconds of artifacts  (example 1591671836538 for Sun, Jun  7, 2020)
# replace REPO for the repository where artifacts are located (example: generic-stage-local)

# find all artifacts created last one day, time are expressed in milliseconds
# grep look for uri attribute in JSON results returned then awk take the corresponding value of the uri attribute. The first 2 sed commands remove the last character and the last sed command remove the first character, ie stripping off the comma and double quotes from the URL in awk  
# refer to https://github.com/nihal-org/scripts/blob/57fa79cafdcd1e82c0865112cf2dac117f99251c/Artifactory-Cleanup.sh

USERNAME=username
PASSWORD=password
ARTIFACTORY=https://artifactory.company.com/artifactory
REPO=generic-stage-local

# which day ago do you want to cleanup
# a long time ago
START_TIME=$(($(date --date="365 days ago" +%s%N)/1000000))
# example 7 days ago
N_DAY_AGO=7
END_TIME=$(($(date --date="$N_DAY_AGO days ago" +%s%N)/1000000))

RESULTS=`curl -s -X GET -u $USERNAME:$PASSWORD "$ARTIFACTORY/api/search/creation?from=$START_TIME&to=$END_TIME&repos=$REPO" | grep uri | awk '{print $3}' | sed s'/.$//' | sed s'/.$//' | sed -r 's/^.{1}//'`

for RESULT in $RESULTS ; do
    echo "Build within $N_DAY_AGO days $RESULT"
    # grep look for downloadUri attribute in JSON results returned then awk take the corresponding value of the downloadUri attribute. The first 2 sed commands remove the last character and the last sed command remove the first character, ie stripping off the comma and double quotes from the URL in awk
    PATH_TO_FILE=`curl -s -X GET -u $USERNAME:$PASSWORD $RESULT | grep downloadUri | awk '{print $3}' | sed s'/.$//' | sed s'/.$//' | sed -r 's/^.{1}//'`
    echo "download path $PATH_TO_FILE"
    # download the corresponding artifact at last
    echo "cleaning up $PATH_TO_FILE"
    curl -u $USERNAME:$PASSWORD -XDELETE $PATH_TO_FILE
done

# TODO: this shell could not cleanup empty folder.
