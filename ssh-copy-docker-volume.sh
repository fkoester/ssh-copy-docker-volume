#! /bin/bash

## Author: Fabian Köster
## License: AGPLv3
## Based on https://www.guidodiepen.nl/2016/05/transfer-docker-data-volume-to-another-host/
## by Guido Diepen

if [ $# -lt 2 ]
then
  echo 'Usage: ./ssh-copy-database.sh <docker volume name> <target host>'
  exit -1
fi

VOLUME=${1}
TARGET_HOST=${2}

REMOTE_CMD="docker volume create ${VOLUME} ; docker run --rm -i -v ${VOLUME}:/to busybox ash -c \"cd /to ; tar -xjvf - \" "

docker run --rm -v ${VOLUME}:/from busybox ash -c "cd /from ; tar -cjf - . " | ssh ${TARGET_HOST} "${REMOTE_CMD}"
