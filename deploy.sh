#!/bin/bash

echo -e "\033[0;32mDeploying updates to vps...\033[0m"

# backup
git add .
git commit -m "备份源码"
git push origin master --force

# Removing existing files
rm -rf public/*
# Build the project
hugo
npm install
npm run algolia 
# Go To Public folder
cd public
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master --force

# Come Back up to the Project Root
cd ..
