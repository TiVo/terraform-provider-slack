#!/bin/bash
set -xeuo pipefail

if [[ $# -lt 2 ]]; then
  echo "ERROR Missing params: BUILD_ID  SRC_DIR  [linux|darwin|windows]"
  exit 1
fi

BID=$1
SRC=$2
OSS=${3:-linux darwin windows}

mkdir -p out/

export CGO_ENABLED=0

for GOOS in ${OSS}; do
  for GOARCH in amd64 arm64; do
    export GOOS GOARCH
    go build -v -o out/${GOOS}_${GOARCH}/${BID} .
  done
done

echo "DONE"
