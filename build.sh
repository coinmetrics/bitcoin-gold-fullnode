#!/bin/sh

set -e

export VERSION=$(cat version.txt)
echo "Image version ${VERSION}."

echo "Building image..."
docker build --build-arg "VERSION=${VERSION}" -t "${DOCKER_REGISTRY_REPO}:${VERSION}" .
echo "Image ready."

if [ -n "${DOCKER_REGISTRY}" ] && [ -n "${DOCKER_REGISTRY_USER}" ] && [ -n "${DOCKER_REGISTRY_PASSWORD}" ]
then
	echo "Logging into ${DOCKER_REGISTRY}..."
	docker login -u="${DOCKER_REGISTRY_USER}" -p="${DOCKER_REGISTRY_PASSWORD}" "${DOCKER_REGISTRY}"
	echo "Pushing image to ${DOCKER_REGISTRY_REPO}:${VERSION}..."
	docker push "${DOCKER_REGISTRY_REPO}:${VERSION}"
fi
