#!/bin/bash

source .env

sudo docker build --tag="kohs100/${IMAGE_TAG}:${IMAGE_VER}" .
sudo docker push kohs100/${IMAGE_TAG}:${IMAGE_VER}