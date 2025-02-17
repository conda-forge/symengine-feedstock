mkdir build
cd build

set "CXXFLAGS="

cmake ^
    -G "Ninja" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_BENCHMARKS=no ^
    -DINTEGER_CLASS=flint ^
    -DWITH_MPC=yes ^
    -DWITH_LLVM=yes ^
    -DWITH_COTIRE=no ^
    -DWITH_SYMENGINE_THREAD_SAFE=yes ^
    -DBUILD_FOR_DISTRIBUTION=yes ^
    -DBUILD_SHARED_LIBS=yes ^
    -DMSVC_USE_MT=no ^
    -DWITH_LLVM_DYLIB=no ^
    ..
if errorlevel 1 exit 1

ninja -j%CPU_COUNT%
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

if "%PKG_VERSION%"=="0.12.0" (
   ctest -E test_cwrapper --output-on-failure
) else (
   ctest --output-on-failure
)
if errorlevel 1 exit 1
