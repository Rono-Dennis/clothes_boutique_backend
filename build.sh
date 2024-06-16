#!/bin/bash

echo "## Starting building java project"
./mvnw clean install
echo "## Finished building java project"

registry="docker.io";  # Docker Hub registry
appName="spring-api-docker";

# UP the version (adjust according to your versioning strategy)
majorVersionFile=major-version.txt;
minorVersionFile=minor-version.txt;

# Check if files exist; if file not found create a file and set the value to 0
if [ ! -f "$majorVersionFile" ]; then
    touch "$majorVersionFile"
    echo "1" > $majorVersionFile
fi

if [ ! -f "$minorVersionFile" ]; then
    touch "$minorVersionFile"
    echo "-1" > $minorVersionFile
fi

read -p "Do you wish to Build and Push docker image with tag $dockerImage? (Yes/No): " yn;
if [ "$yn" = "Yes" ]; then
    majorVersion=$(cat $majorVersionFile)
    minorVersion=$(cat $minorVersionFile)

    prevImage="$registry/$appName:$majorVersion.$minorVersion";
    echo "Previous image: $prevImage";

    minorVersion=$((minorVersion + 1));
    if (($minorVersion > 9)); then
        majorVersion=$((majorVersion + 1));
        minorVersion=0;
    fi;

    printf "$majorVersion" > $majorVersionFile
    printf "$minorVersion" > $minorVersionFile
    tag="$majorVersion.$minorVersion"
    dockerImage="$registry/ronodennis/$appName:$tag";
    echo "New image: $dockerImage";

    echo "## - Finished preparing the image version"

    echo "Start building docker image"
    docker build -t $dockerImage .
    echo "Finished building docker image"

    echo "Start pushing docker image"
    docker login -u ronodennis
    docker push $dockerImage
    docker logout
    echo "Finished pushing docker image"

    echo "Removing previous Image"
    docker rmi $prevImage
else
    echo "Docker build skipped"
fi









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
