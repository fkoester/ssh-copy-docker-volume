#! /bin/bash

## Based on https://www.guidodiepen.nl/2016/05/transfer-docker-data-volume-to-another-host/
## by Guido Diepen

if [ $# -lt 2 ]
then
  echo 'Usage: ./ssh-copy-database.sh <docker volume name> <target host>'
  exit -1
fi

VOLUME="${1}"
TARGET_HOST=${2}

docker run --rm -v ${VOLUME}:/from alpine ash -c "cd /from ; tar -cjf - . " | ssh ${TARGET_HOST} "docker run --rm -i -v ${VOLUME}:/to alpine ash -c \"cd /to ; tar -xjvf - \" "
