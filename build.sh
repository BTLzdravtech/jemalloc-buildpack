#!/bin/bash
# usage: build [version] [stack]
set -e

version=$1
stack=$2
build=`mktemp -d`

tar -C $build --strip-components=1 -xj -f /wrk/src/jemalloc-$version.tar.bz2

cd $build
./configure --prefix=/layers/btl_jemalloc/jemalloc/package
make -j $(nproc --all) install_bin install_lib_shared

# Bundle and compress the compiled library
mkdir -p /wrk/dist/$stack
tar -C /layers/btl_jemalloc/jemalloc/package/ -c . | bzip2 -9 > /wrk/dist/$stack/jemalloc-$version.tar.bz2
