#! /bin/bash
read -p "enter version: " version
read -p "enter commit hash: " commit_hash
git tag -a "$version" -m "$commit_hash"
git push origin "$version"
docker build -t chat .
