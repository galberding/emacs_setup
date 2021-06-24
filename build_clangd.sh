#!/bin/bash

set -e

# Git settings
BRANCH_NAME=release/11.x
GIT_REPO=https://github.com/llvm/llvm-project.git

LLVM_PROJECTS="clang;clang-tools-extra"

# Create workspace dir
SRC_SUFFIX=llvm-project
BUILD_SUFFIX=build
INSTALL_SUFFIX=clangd
mkdir -p $SRC_SUFFIX
cd $SRC_SUFFIX

# Define environment variables
CURRENT_WD=`pwd`
SRC_DIR=$CURRENT_WD/$SRC_SUFFIX
BUILD_DIR=$CURRENT_WD/$BUILD_SUFFIX
INSTALL_DIR=$CURRENT_WD/$INSTALL_SUFFIX
CPU_CORES=`nproc`

# Clone sources if not already existent
if [ ! -d $SRC_DIR ]; then
    echo "Could not find src directory, cloning from git ..."
    git clone $GIT_REPO
else
    echo "Found src files."
fi

# Create intall and build dir
cd $CURRENT_WD
mkdir -p $BUILD_DIR $INSTALL_DIR

# Checkout the desired branch
cd $SRC_DIR
# git checkout $BRANCH_NAME

# Build/Install
# TODO: Build specific stuff here
cd $BUILD_DIR
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DLLVM_ENABLE_PROJECTS=$LLVM_PROJECTS $SRC_DIR/llvm
make -j$CPU_CORES
make install
