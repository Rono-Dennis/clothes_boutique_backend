#!/bin/bash

# Variables
IMAGE_NAME="ronodennis/spring-api-docker"
JAR_NAME="spring-api-docker"
MAJOR_VERSION_FILE="major-version.txt"
MINOR_VERSION_FILE="minor-version.txt"
DOCKER_USERNAME="ronodennis"
DOCKER_PASSWORD="0iL2zQh3vCRl4TL"

# Ensure Docker credentials are set in environment variables
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_PASSWORD" ]; then
  echo "Error: DOCKER_USERNAME and DOCKER_PASSWORD environment variables must be set."
  exit 1
fi

# Function to increment the minor version
increment_version() {
  if [ -z "$MINOR_VERSION" ]; then
    echo "Error: MINOR_VERSION is not set"
    exit 1
  fi

  if [ "$MINOR_VERSION" -eq 9 ]; then
    MAJOR_VERSION=$((MAJOR_VERSION + 1))
    MINOR_VERSION=0
  else
    MINOR_VERSION=$((MINOR_VERSION + 1))
  fi
}

# Function to login to Docker
docker_login() {
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  if [ $? -ne 0 ]; then
    echo "Docker login failed"
    exit 1
  fi
}

# Function to logout from Docker
docker_logout() {
  docker logout
}

# Check if version files exist; if not, create them and initialize values
if [ ! -f "$MAJOR_VERSION_FILE" ]; then
  echo "1" > $MAJOR_VERSION_FILE
fi

if [ ! -f "$MINOR_VERSION_FILE" ]; then
  echo "-1" > $MINOR_VERSION_FILE
fi

# Read version from files
MAJOR_VERSION=$(cat "$MAJOR_VERSION_FILE")
MINOR_VERSION=$(cat "$MINOR_VERSION_FILE")

# Check if the version files are correctly formatted
if ! [[ "$MAJOR_VERSION" =~ ^[0-9]+$ ]] || ! [[ "$MINOR_VERSION" =~ ^-?[0-9]+$ ]]; then
  echo "Error: Version files are not correctly formatted. Expected integer values."
  exit 1
fi

# Debug statements
echo "Initial MAJOR_VERSION: $MAJOR_VERSION"
echo "Initial MINOR_VERSION: $MINOR_VERSION"

# Increment version
increment_version

# Debug statements
echo "Updated MAJOR_VERSION: $MAJOR_VERSION"
echo "Updated MINOR_VERSION: $MINOR_VERSION"

# Build the Maven project
mvn clean package -DskipTests
if [ $? -ne 0 ]; then
  echo "Maven build failed"
  exit 1
fi

# Build the Docker image
docker build -t ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} .
if [ $? -ne 0 ]; then
  echo "Docker build failed"
  exit 1
fi

# Tag the Docker image as latest
docker tag ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} ${IMAGE_NAME}:latest

# Login to Docker
docker_login

# Push the Docker image
docker push ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}
if [ $? -ne 0 ]; then
  echo "Docker push failed"
  exit 1
fi

docker push ${IMAGE_NAME}:latest
if [ $? -ne 0 ]; then
  echo "Docker push failed"
  exit 1
fi

# Logout from Docker
docker_logout

# Save the new version to the version files
echo "${MAJOR_VERSION}" > "$MAJOR_VERSION_FILE"
echo "${MINOR_VERSION}" > "$MINOR_VERSION_FILE"

echo "Build, Docker image creation, and push completed successfully"
echo "New version: ${MAJOR_VERSION}.${MINOR_VERSION}"







##!/bin/bash
#
## Variables
#IMAGE_NAME="ronodennis/k8s-terraform-spring-mysql"
#JAR_NAME="k8s-terraform-spring-myqsl-demo"
#DOCKER_USERNAME="ronodennis"
#DOCKER_PASSWORD="0iL2zQh3vCRl4TL"
#VERSION_FILE="version.txt"
#
## Function to increment the minor version
#increment_version() {
#  if [ $MINOR_VERSION -eq 9 ]; then
#    MAJOR_VERSION=$((MAJOR_VERSION + 1))
#    MINOR_VERSION=0
#  else
#    MINOR_VERSION=$((MINOR_VERSION + 1))
#  fi
#}
#
## Function to login to Docker
#docker_login() {
#  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
#  if [ $? -ne 0 ]; then
#    echo "Docker login failed"
#    exit 1
#  fi
#}
#
## Function to logout from Docker
#docker_logout() {
#  docker logout
#}
#
## Check if version file exists
#if [ -f "$VERSION_FILE" ]; then
#  # Read version from file
#  MAJOR_VERSION=$(cut -d '.' -f 1 $VERSION_FILE)
#  MINOR_VERSION=$(cut -d '.' -f 2 $VERSION_FILE)
#else
#  # Initialize version if file does not exist
#  MAJOR_VERSION=1
#  MINOR_VERSION=0
#fi
#
## Increment version
#increment_version
#
## Build the Maven project
#mvn clean package -DskipTests
#if [ $? -ne 0 ]; then
#  echo "Maven build failed"
#  exit 1
#fi
#
## Build the Docker image
#docker build -t ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} .
#if [ $? -ne 0 ]; then
#  echo "Docker build failed"
#  exit 1
#fi
#
## Tag the Docker image as latest
#docker tag ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} ${IMAGE_NAME}:latest
#
## Login to Docker
#docker_login
#
## Push the Docker image
#docker push ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}
#if [ $? -ne 0 ]; then
#  echo "Docker push failed"
#  exit 1
#fi
#
#docker push ${IMAGE_NAME}:latest
#if [ $? -ne 0 ]; then
#  echo "Docker push failed"
#  exit 1
#fi
#
## Logout from Docker
#docker_logout
#
## Save the new version to the version file
#echo "${MAJOR_VERSION}.${MINOR_VERSION}" > $VERSION_FILE
#
#echo "Build, Docker image creation, and push completed successfully"
#echo "New version: ${MAJOR_VERSION}.${MINOR_VERSION}"












##!/bin/bash
#
## Variables
#MAJOR_VERSION=1
#MINOR_VERSION=0
#IMAGE_NAME="ronodennis/k8s-terraform-spring-mysql"
#JAR_NAME="k8s-terraform-spring-myqsl-demo"
#DOCKER_USERNAME="ronodennis"
#DOCKER_PASSWORD="0iL2zQh3vCRl4TL"
#
## Function to increment the minor version
#increment_minor_version() {
#  MINOR_VERSION=$((MINOR_VERSION + 1))
#}
#
## Function to login to Docker
#docker_login() {
#  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
#  if [ $? -ne 0 ]; then
#    echo "Docker login failed"
#    exit 1
#  fi
#}
#
## Function to logout from Docker
#docker_logout() {
#  docker logout
#}
#
## Increment minor version
#increment_minor_version
#
## Build the Maven project
#mvn clean package -DskipTests
#if [ $? -ne 0 ]; then
#  echo "Maven build failed"
#  exit 1
#fi
#
## Build the Docker image
#docker build -t ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} .
#if [ $? -ne 0 ]; then
#  echo "Docker build failed"
#  exit 1
#fi
#
## Tag the Docker image as latest
#docker tag ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION} ${IMAGE_NAME}:latest
#
## Login to Docker
#docker_login
#
## Push the Docker image
#docker push ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}
#if [ $? -ne 0 ]; then
#  echo "Docker push failed"
#  exit 1
#fi
#
#docker push ${IMAGE_NAME}:latest
#if [ $? -ne 0 ]; then
#  echo "Docker push failed"
#  exit 1
#fi
#
## Logout from Docker
#docker_logout
#
#echo "Build, Docker image creation, and push completed successfully"
