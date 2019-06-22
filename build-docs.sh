#!/usr/bin/env bash

# Description: Build script
# Author: retgits <https://github.com/retgits>
# Last Updated: 2018-11-26

#--- Variables ---
HUGO_VERSION=0.49

#--- Download and install prerequisites ---
prerequisites() {
    wget -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
    mkdir -p hugobin
    tar -xzvf hugo.tar.gz -C ./hugobin
    mv ./hugobin/hugo $HOME/gopath/bin
    rm hugo.tar.gz && rm -rf ./hugobin
}

#--- Execute build ---
build() {
    echo "Build docs site..."
    cd docs && hugo
    cd public && ls -alh
}


case "$1" in 
    "prerequisites")
        prerequisites
        ;;
    "build")
        build
        ;;
    *)
        echo "The target {$1} you want to execute doesn't exist"
esac