
#!/bin/bash

# Get the version and commit hash from the user
version=$(read -p "Enter the version: ")
commit_hash=$(read -p "Enter the commit hash: ")

# Check if the image exists
image_name="chat-app:${version}"

if docker images -q $image_name; then
  # Ask the user if they want to rebuild the image
  read -p "Do you want to rebuild the image? (y/n): " rebuild_image

  if [[ $rebuild_image == "y" ]]; then

    # Delete the existing image
    docker rmi $image_name

    # Build the image
  fi
fi
  # Build the image
  docker build -t $image_name:$version .


git tag -a "$version" -m "$commit"
git push origin "$version"
# Tag the image
docker tag $version rg2023/chat-app:$version

# Push the image to your GitHub repository
docker push rg2023/chat-app:$image_name:${version}  



