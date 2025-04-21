#!/bin/bash

source .env

sudo docker build --tag="${IMAGE_TAG}:${IMAGE_VER}" .
