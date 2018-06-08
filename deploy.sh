#!/usr/bin/env bash
set -eo pipefail

# Push our latest revision to GitHub
git push origin develop

# Clean rebuild
stack exec ufabc-hal clean
stack exec ufabc-hal site

# Create deploy environment inside of .deploy directory
mkdir .deploy
cd .deploy
git init
git remote add origin https://github.com/UFABC-HAL/ufabc-hal.github.io.git

# Add built site files
rsync -a ../_site/ .
git add .
git commit -m 'Publish'
git push -f origin master

# Cleanup .deploy directory after a successful push
cd .. && rm -rf .deploy
