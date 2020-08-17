#!/bin/bash

# This script will clone the current
# Spacemacs inside it
# After that the develop branch will be checked out and the SPACE_CONFIG will
# be copied into place

CURRENT=$(pwd)
SPACE_REPO=https://github.com/syl20bnr/spacemacs
SPACE_CONFIG=.spacemacs
BRANCH=develop
EMACS_DIR=$(HOME)/.emacs.d


# Clone spacemacs
git clone $SPACE_REPO $EMACS_DIR

# Checkout develop
cd $EMACS_DIR
git checkout $BRANCH

cd $CURRENT
cp $SPACE_CONFIG $(HOME)/$SPACE_CONFIG
