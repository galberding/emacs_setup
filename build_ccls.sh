#!/bin/bash

set -e
#module load gcc

# Git settings
BRANCH_NAME=emacs-27
GIT_REPO=https://github.com/MaskRay/ccls

# Path to external repo to place the installation
INSTALL_REPO=
TMP_REPO=
# Create workspace dir
SRC_SUFFIX=ccls
BUILD_SUFFIX=build
INSTALL_SUFFIX=install
mkdir -p $SRC_SUFFIX
cd $SRC_SUFFIX

# Define environment variables
CURRENT_WD=`pwd`
LLVM_BINARIES=$CURRENT_WD/llvm/clang+llvm-10.0.1-powerpc64le-linux-ubuntu-16.04
SRC_DIR=$CURRENT_WD/$SRC_SUFFIX
BUILD_DIR=$CURRENT_WD/$BUILD_SUFFIX
INSTALL_DIR=$CURRENT_WD/$INSTALL_SUFFIX
PREFIX_DIR=$INSTALL_REPO/$INSTALL_SUFFIX
CPU_CORES=`nproc`

# Clone sources if not already existent
if [ ! -d $SRC_DIR ]; then
    echo "Could not find src directory, cloning from git ..."
    git clone --recursive $GIT_REPO
else
    echo "Found src files."
fi

# Create intall and build dir
cd $CURRENT_WD
mkdir -p $BUILD_DIR $INSTALL_DIR

set -e
# Checkout the desired branch
cd $SRC_DIR
cmake -H. -BRelease -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR # -DCMAKE_BUILD_TYPE=Release  -DCMAKE_PREFIX_PATH=$LLVM_BINARIES
cmake --build Release --target install
# set +e
# make clean
# set -e

# $SRC_DIR/configure --prefix=$INSTALL_DIR
# make -j$CPU_CORES
# make install
