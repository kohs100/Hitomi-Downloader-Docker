#!/bin/bash

source .env

if [ ! -d "$DST_PATH" ]; then
  echo "Error: $DST_PATH does not exist."
  exit
fi

DST_PERM=`stat -L -c "%u" $DST_PATH`

if [ ! "$DST_PERM" = "$TARGET_UID" ]; then
  NUID=$(id -nu "$TARGET_UID")
  CNUID=$(id -nu "$DST_PERM")
  echo "Error: Destination directory ownership mismatch."
  echo "$DST_PATH should be owned by $NUID but currently owned by $CNUID"
  exit
fi 

CONTAINER_NAME="hdl-container"

sudo docker run \
  --detach \
  --interactive \
  --tty \
  --name $CONTAINER_NAME \
  --volume ${DST_PATH}:/home/${USER_IN_CONTAINER}/hitomi_downloaded \
  --publish-all \
  "${IMAGE_TAG}:${IMAGE_VER}"