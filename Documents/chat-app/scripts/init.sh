#!/bin/bash
version='latest'
if [ $# -ne 0 ]; then
  # Arguments were passed, so use them
  version=$1
fi

docker build -t  chat-app:${version} .
docker run -p 5000:5000 --name chat-App-run chat-app:${version}

#gcloud auth configure-docker me-west1-docker.pkg.dev 
#gcloud config set project grunitech-mid-project
#gcloud config unset auth/impersonate_service_account
#gcloud auth login
#gcloud compute ssh rachel058326@rachel-gershon-first-instance --project grunitech-mid-project --zone me-west1-a 
#docker volume create chat-app-data
#docker pull me-west1-docker.pkg.dev/grunitech-mid-project/rachel-gershon-chat-app-images/chat-app:v0.0.4
#docker run -v chat-app-data:/code/data -p 8080:80 --name chat-app-run me-west1-docker.pkg.dev/grunitech-mid-project/rachel-gershon-chat-app-images/chat-app:${version};"



