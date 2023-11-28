#!/bin/bash
set -ex

# Build the docker to take the snapshot of the binary
docker build \
    -f ./Dockerfile \
    -t snapchange_multiproc \
    .

# Take the snapshot for this binary
docker run -i \
    -v $(realpath -m ./snapshot):/snapshot/ \
    -e SNAPSHOT_IMGTYPE=initramfs \
    snapchange_multiproc
