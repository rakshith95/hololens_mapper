#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" || "$(expr substr $(uname -s) 1 5)" == "Linux"]; then
    # Singularity containers
    singularity build ./alicevision.sif docker://alicevision/meshroom:2021.1.0-av2.4.0-centos7-cuda10.2
    singularity build ./colmap.sif docker://uodcvip/colmap:latest
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT"]; then
    # Docker images
    docker pull alicevision/meshroom:2021.1.0-av2.4.0-centos7-cuda10.2
    docker pull uodcvip/colmap:latest
fi

# create common conda enviroment
conda env create -f environment.yml

# compile the C++ codes
# renderDepth.cpp
mkdir ./src/utils/renderDepth/build
cd ./src/utils/renderDepth/build
cmake --build . --config Release --target install