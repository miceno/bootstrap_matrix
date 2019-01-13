#!/usr/bin/env bash

DIST_DIR="dist"

mkdir -p $DIST_DIR

tar -cvf - -T MANIFEST.txt | tar -C $DIST_DIR -xvf -
