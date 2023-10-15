#!/bin/bash
version='latest'
if [ $# -ne 0 ]; then
  # Arguments were passed, so use them
  version=$1
fi



#docker build -t  chat-app:${version} .
#|docker run -p 5000:5000 --name chat-App-run chat-app:${version}



gcloud compute ssh rachel058326@rachel-gershon-first-instance --project grunitech-mid-project --zone me-west1-a 
docker volume create chat-app-data
docker pull me-west1-docker.pkg.dev/grunitech-mid-project/rachel-gershon-chat-app-images/chat-app:${version}
docker run -v chat-app-data:/code/data -p 8080:5000 --name chat-app-run me-west1-docker.pkg.dev/grunitech-mid-project/rachel-gershon-chat-app-images/chat-app:${version}



