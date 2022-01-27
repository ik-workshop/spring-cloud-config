#!/bin/bash

set -ex

: "${IMAGE}"
: "${IMAGE_ID}"
: "${TAG_VERSION_DATE}"
: "${TAG_VERSION_SHA}"
: "${IMAGE_VERSION:-latest}"

echo "push version ${IMAGE_ID}:latest"
docker tag "${IMAGE}" "${IMAGE_ID}:latest"
docker push "${IMAGE_ID}:latest"

echo "push version ${IMAGE_ID}:${TAG_VERSION_DATE}"
docker tag "${IMAGE}" "${IMAGE_ID}:${TAG_VERSION_DATE}"
docker push "${IMAGE_ID}:${TAG_VERSION_DATE}"

echo "push version ${IMAGE_ID}:${TAG_VERSION_SHA}"
docker tag "${IMAGE}" "${IMAGE_ID}:${TAG_VERSION_SHA}"
docker push "${IMAGE_ID}:${TAG_VERSION_SHA}"
