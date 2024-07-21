#!/bin/bash

source .env



if [ "$TARGET_UID" -ne 0 ]; then
  NUID=`id -nu "$TARGET_UID"`
  NGID=`id -nu "$TARGET_GID"`
  echo "Build target user: $NUID"
  echo "Build target group: $NGID"
else
  echo "Please specify non-root user."
  exit
fi

sudo docker build \
  --build-arg="EUID=$TARGET_UID" \
  --build-arg="EGID=$TARGET_GID" \
  --build-arg="UNAME=$USER_IN_CONTAINER" \
  --build-arg="UPASS=$PASS_IN_CONTAINER" \
  --tag="${IMAGE_TAG}:${IMAGE_VER}" \
  .
