#!/bin/bash

set -e
#module load gcc

# Git settings
BRANCH_NAME=emacs-27
GIT_REPO=https://git.savannah.gnu.org/git/emacs.git

# Path to external repo to place the installation
INSTALL_REPO=
TMP_REPO=
# Create workspace dir
SRC_SUFFIX=emacs
BUILD_SUFFIX=build
INSTALL_SUFFIX=$BRANCH_NAME
mkdir -p $SRC_SUFFIX
cd $SRC_SUFFIX

# Define environment variables
CURRENT_WD=`pwd`
SRC_DIR=$CURRENT_WD/$SRC_SUFFIX
BUILD_DIR=$CURRENT_WD/$BUILD_SUFFIX
INSTALL_DIR=$CURRENT_WD/$INSTALL_SUFFIX
PREFIX_DIR=$INSTALL_REPO/$INSTALL_SUFFIX
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
git checkout $BRANCH_NAME
# git checkout -b native-comp origin/feature/native-comp

# GEnerate Config
cd $SRC_DIR
./autogen.sh
cd $BUILD_DIR

set +e
make clean
set -e

$SRC_DIR/configure --prefix=$INSTALL_DIR --with-native-compilation --with-mailutils
make -j$CPU_CORES
make install
