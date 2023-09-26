#!/bin/bash

version=$1
commit_hash=$2

if [[ -z $version && -z $commit_hash ]]; then
    echo "missing parameters"
    exit 1
fi

image_name="chat-app:$version"

# Check if the Docker image exists
if [[ "$(docker images -q $image_name)" ]]; then
    echo "The Docker image $image_name already exists."
    read -p "Do you want to rebuild the image? (y/n): " rebuild_choice

    if [[ $rebuild_choice == [Yy] ]]; then
        # Delete the existing Docker image
        docker rmi $image_name
        docker build -t chatapp:$version .
    fi
else
    docker build -t chatapp:$version .
fi


git tag $version $commit_hash

git push origin $version



