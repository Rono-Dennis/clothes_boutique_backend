#!/bin/bash

# Variables
IMAGE_NAME="ronodennis/k8s-terraform-spring-mysql"
JAR_NAME="k8s-terraform-spring-myqsl-demo"
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
#echo "## Starting building java project"
#./mvnw clean install
#echo "## finished building java project"
#
#registry="docker.io";  # Docker Hub registry
#appName="spring-api-docker";
#
##UP the version
#majorVersionFile=major-version.txt;
#minorVersionFile=minor-version.txt;
#
##check if files exist, if file not found create a file and set the value to 0
#if [ ! -f "$majorVersionFile" ]; then
#    touch "$majorVersionFile"
#    printf "1" > $majorVersionFile
#fi
#
#if [ ! -f "$minorVersionFile" ]; then
#    touch "$minorVersionFile"
#    printf "-1" > $minorVersionFile
#fi
#
#read -p "Do you wish to Build and Push docker image with tag $dockerImage? (Yes/No): " yn;
#if [ "$yn" = "Yes" ]; then
#    majorVersion=$(cat $majorVersionFile)
#    minorVersion=$(cat $minorVersionFile)
#
#    prevImage="$registry/$appName:$majorVersion.$minorVersion";
#    echo "Previous image: $prevImage";
#
#    minorVersion=$((minorVersion + 1));
#    if (($minorVersion > 9)); then
#        majorVersion=$((majorVersion + 1));
#        minorVersion=0;
#    fi;
#
#    printf "$majorVersion" > $majorVersionFile
#    printf "$minorVersion" > $minorVersionFile
#    tag="$majorVersion.$minorVersion"
#    dockerImage="$registry/ronodennis/$appName:$tag";
#    echo "New image: $dockerImage";
#
#    echo "## - finished preparing the image version"
#
#    echo "Start building docker image"
#    docker build -t $dockerImage .
#    echo "Finished building docker image"
#
#    echo "Start pushing docker image"
#    docker login -u ronodennis
#    docker push $dockerImage
#    docker logout
#    echo "Finished pushing docker image"
#
#    echo "Removing previous Image"
#    docker rmi $prevImage
#else
#    echo "Docker build skipped"
#fi













##!/bin/sh
#
#echo "## Starting building java project"
#./mvnw clean install
#echo "## finished building java project"
#
#registry="docker.io";  # Docker Hub registry
#appName="spring-api-docker";
#
##UP the version
#majorVersionFile=major-version.txt;
#minorVersionFile=minor-version.txt;
#
##check if files exist, if file not found create a file and set the value to 0
#if [ ! -f "$majorVersionFile" ]; then
#    touch "$majorVersionFile"
#    printf "1" > $majorVersionFile
#fi
#
#if [ ! -f "$minorVersionFile" ]; then
#    touch "$minorVersionFile"
#    printf "-1" > $minorVersionFile
#fi
#
#read -p "Do you wish to Build and Push docker image with tag $dockerImage? (Yes/No): " yn;
#if [ "$yn" = "Yes" ]; then
#    majorVersion=`cat $majorVersionFile`
#    minorVersion=`cat $minorVersionFile`
#
#    prevImage="$registry/$appName:$majorVersion.$minorVersion";
#    echo $prevImage;
#
#    minorVersion=$((minorVersion + 1));
#    if (($minorVersion > 9)); then
#        majorVersion=$((majorVersion + 1));
#        minorVersion=0;
#    fi;
#
#    printf "$majorVersion" > $majorVersionFile
#    printf "$minorVersion" > $minorVersionFile
#    tag="$majorVersion.$minorVersion"
#    dockerImage="$registry/ronodennis/$appName:$tag";
#    echo $dockerImage;
#
#    echo "## - finished preparing the image version"
#
#    echo "Start building docker image"
#    docker build -t $dockerImage .
#    echo "finished building docker image"
#
#    echo "Start pushing docker image"
#    docker login -u ronodennis
#    docker push $dockerImage
#    docker logout
#    echo "finished pushing docker image"
#
#    echo "Removing previous Image"
#    docker rmi $prevImage
#else
#    echo "Docker build skipped"
#fi




##!/bin/sh
#
#echo "## Starting building java project"
#./mvnw clean install
#echo "## finished building java project"
#
#registry="docker.io";  # Docker Hub registry
#appName="authserver-app";
#
##UP the version
#majorVersionFile=major-version.txt;
#minorVersionFile=minor-version.txt;
#
##check if files exist, if file not found create a file and set the value to 0
#if [ ! -f "$majorVersionFile" ]; then
#    touch "$majorVersionFile"
#    printf "1" > $majorVersionFile
#fi
#
#if [ ! -f "$minorVersionFile" ]; then
#    touch "$minorVersionFile"
#    printf "-1" > $minorVersionFile
#fi
#
#read -p "Do you wish to Build and Push docker image with tag $dockerImage? (Yes/No): " yn;
#if [ "$yn" = "Yes" ]; then
#    majorVersion=$(cat $majorVersionFile)
#    minorVersion=$(cat $minorVersionFile)
#
#    prevImage="$registry/$appName:$majorVersion.$minorVersion";
#    echo $prevImage;
#
#    minorVersion=$((minorVersion + 1));
#    if [ $minorVersion -gt 9 ]; then
#        majorVersion=$((majorVersion + 1));
#        minorVersion=0;
#    fi;
#
#    printf "$majorVersion" > $majorVersionFile
#    printf "$minorVersion" > $minorVersionFile
#    tag="$majorVersion.$minorVersion"
#    dockerImage="$registry/your-dockerhub-username/$appName:$tag";
#    echo $dockerImage;
#
#    echo "## - finished preparing the image version"
#
#    echo "Start building docker image"
#    docker build -t $dockerImage .
#    echo "finished building docker image"
#
#    echo "Start pushing docker image"
#
#    # Ensure the environment variables DOCKER_USERNAME and DOCKER_PASSWORD are set
#    if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_PASSWORD" ]; then
#        echo "Error: DOCKER_USERNAME or DOCKER_PASSWORD environment variables are not set."
#        exit 1
#    fi
#
#    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
#    docker push $dockerImage
#    docker logout
#    echo "finished pushing docker image"
#
#    echo "Removing previous Image"
#    docker rmi $prevImage
#else
#    echo "Docker build skipped"
#fi
