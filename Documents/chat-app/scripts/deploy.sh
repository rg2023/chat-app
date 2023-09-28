#!/bin/bash

read -p "Enter version: " version
git log --oneline
read -p "Enter commit hash: " commit_hash

image_name=chat-app:${version}

# Check if the Docker image exists
if [[ "$(docker images -q $image_name)" ]]; then
    read -p "Image $image_name already exists. Do you want to rebuild it (y/n)? " rebuild
    # If the user chooses to rebuild the image, delete the existing one.
    if [[ "$rebuild" == "y" ]]; then
        # Delete the existing image
        docker rmi "chat-app:$version"
        docker build -t "chat-app:$version" .
    else
         echo "Using existing image chat-app:$version."
    fi


else
    # Build the Docker image
    docker build -t "chat-app:$version" .
fi
read -p "Do you want to push tag to git: " tag_and_push

if [[ $tag_and_push == "true" ]]; then
        git tag $version $commit_hash
        git push origin $version
fi


   read -p "Do you want to push the image to Artifact Registry? (y/n): " push_to_registry
    if [[ "$push_to_registry" == "y" ]]; then
      gcloud config set auth/impersonate_service_account artifact-admin-sa@grunitech-mid-project.iam.gserviceaccount.com  
      gcloud auth configure-docker me-west1-docker.pkj.dev
      docker tag chat-app:${version} me-west1-docker.pkg.dev/grunitech-mid-project/	 rachel-gershon-chat-app-images/chat-app:${version}
      docker push me-west1-docker.pkg.dev/grunitech-mid-project/rachel-gershon-chat-app-images/chat-app:${version}
    else
        echo "Image not pushed to Artifact Registry."
    fi