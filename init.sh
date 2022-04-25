#!/usr/bin/env bash

# install the poselib for testing 
# install the Eigen 3.4.0 --> https://gitlab.com/libeigen/eigen/-/releases/3.4.0
# conda env --name poselib python=3.8
# conda activate poselib
# conda install pybind11
# cd third_party/poselib
# cmake -S . -B _build/ -DPYTHON_PACKAGE=ON -DCMAKE_INSTALL_PREFIX=_install
# cmake --build _build/ --target pip-package
# cmake --build _build/ --target install -j 8
# cmake --build _build/ --target install-pip-package
# cd ../..

# create common conda enviroment
conda env create -f environment.yml
conda activate meshroom

# download large files 
mkdir ./third_party/Hierarchical-Localization/third_party/netvlad
wget --no-check-certificate https://cvg-data.inf.ethz.ch/hloc/netvlad/Pitts30K_struct.mat -O ./third_party/Hierarchical-Localization/third_party/netvlad/VGG16-NetVLAD-Pitts30K.mat
echo "Wget done"
# create containers
if [ "$(uname) == Darwin" || "$(expr substr $(uname -s) 1 5)" == "Linux"]; then
    # Singularity containers
    echo "Init singularity containers"
    singularity build ./alicevision.sif docker://alicevision/meshroom:2021.1.0-av2.4.0-centos7-cuda10.2
    echo "Alicevision done"
    singularity build ./colmap.sif docker://uodcvip/colmap:latest
    echo "Colmap done"
    singularity build --fakeroot ./hloc.sif ./third_party/Hierarchical-Localization/Singularity.def
    echo "Hloc done"
    singularity build --fakeroot ./patchmatchnet.sif ./third_party/PatchmatchNet/Singularity.def
    echo "PatchMatch done"
    singularity build --fakeroot ./ricp.sif ./third_party/Fast-Robust-ICP/Singularity.def
    echo "RICP done"
    #singularity build --fakeroot ./predator.sif ./third_party/OverlapPredator/Singularity.def
    #echo "Overlap Predator done"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT"]; then
    # Docker images
    docker pull alicevision/meshroom:2021.1.0-av2.4.0-centos7-cuda10.2
    docker pull uodcvip/colmap:latest
    docker build -t hloc:latest ./third_party/Hierarchical-Localization
    docker build -t patchmatchnet ./third_party/PatchmatchNet
    docker build -t ricp ./third_party/Fast-Robust-ICP
fi
echo "Compiling C++ codes"
# compile the C++ codes
mkdir ./src/utils/srcRenderDepth/build
cd ./src/utils/srcRenderDepth/build
cmake ..
cmake --build . --config Release --target install
echo "RenderDepth done"
cd ../../../..
mkdir ./src/meshroom/MeshroomCpp/build
cd ./src/meshroom/MeshroomCpp/build
cmake ..
cmake --build . --config Release --target install
echo "Meshroom done"
