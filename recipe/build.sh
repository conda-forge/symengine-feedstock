#!/usr/bin/env bash

if [[ "${target_platform}" == "linux-ppc64le" ]]; then
  export CFLAGS="${CFLAGS//-fno-plt/}"
  export CXXFLAGS="${CXXFLAGS//-fno-plt/}"
fi

cmake ${CMAKE_ARGS} -G Ninja \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_UNITY_BUILD=ON \
    -DBUILD_BENCHMARKS=no \
    -DINTEGER_CLASS=flint \
    -DWITH_SYMENGINE_THREAD_SAFE=yes \
    -DWITH_MPC=yes \
    -DWITH_FLINT=yes \
    -DWITH_LLVM=yes \
    -DBUILD_FOR_DISTRIBUTION=yes \
    -DBUILD_SHARED_LIBS=yes \
    -DWITH_LLVM_DYLIB=no \
    -B build .

cmake --build build --target install -j${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --test-dir build --output-on-failure
fi
