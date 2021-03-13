#!/usr/bin/env bash

mkdir build
cd build

cmake ${CMAKE_ARGS} \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_BENCHMARKS=no \
    -DINTEGER_CLASS=flint \
    -DWITH_SYMENGINE_THREAD_SAFE=yes \
    -DWITH_MPC=yes \
    -DWITH_FLINT=yes \
    -DWITH_LLVM=yes \
    -DBUILD_FOR_DISTRIBUTION=yes \
    -DBUILD_SHARED_LIBS=yes \
    ..

cmake --build . -- -j${CPU_COUNT}
cmake --build . --target install

if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
ctest
fi
