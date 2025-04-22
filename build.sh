#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ROOT_DIR=$SCRIPT_DIR

BUILD_DIR=$ROOT_DIR/build

build() {
    if [ ! -d $BUILD_DIR ]; then
        mkdir -p $BUILD_DIR
    fi

    pushd $BUILD_DIR >/dev/null
        cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo $ROOT_DIR -G Ninja
    popd >/dev/null

    pushd $BUILD_DIR >/dev/null
        ninja
    popd >/dev/null
}

build