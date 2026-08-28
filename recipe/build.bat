set "CXXFLAGS="

cmake ^
    -G "Ninja" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_UNITY_BUILD=ON ^
    -DBUILD_BENCHMARKS=no ^
    -DINTEGER_CLASS=flint ^
    -DWITH_MPC=yes ^
    -DWITH_LLVM=yes ^
    -DWITH_SYMENGINE_THREAD_SAFE=yes ^
    -DBUILD_FOR_DISTRIBUTION=yes ^
    -DBUILD_SHARED_LIBS=yes ^
    -DMSVC_USE_MT=no ^
    -DWITH_LLVM_DYLIB=no ^
    -B build .
if errorlevel 1 exit 1

cmake --build build --target install -j%CPU_COUNT%
if errorlevel 1 exit 1

ctest --test-dir build --output-on-failure
if errorlevel 1 exit 1
