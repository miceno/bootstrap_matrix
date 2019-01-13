#!/usr/bin/env bash

DIST_DIR="dist"
THEME_NAME="bootstrap_matrix"

SHORT_HEAD=$(git rev-parse --short HEAD)

TARGET_DIR=$DIST_DIR/$THEME_NAME-$SHORT_HEAD
mkdir -p $TARGET_DIR

tar -cvf - -T MANIFEST.txt | tar -C $TARGET_DIR -xvf -
