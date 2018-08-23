#!/bin/bash -x
set -o errexit

target="powerpc-ppu"

prefix="$PWD/install"

sysroot="$prefix/$target"

export PATH="$prefix/bin:$sysroot/bin:$PATH"

export CPATH="$sysroot/include"

cxxflags="-fno-exceptions -ffunction-sections -fdata-sections"

config_options_libstd="
--disable-nls
--disable-multilib
--enable-libstdcxx-allocator=new
--disable-libstdcxx-pch
--disable-libstdcxx-threads
--disable-libstdcxx-verbose
--disable-shared
--with-newlib
--with-cross-host=$target
--disable-linux-futex
--disable-sjlj-exceptions
"

mkdir -p build_libstdc++
cd build_libstdc++

../gcc/libstdc++-v3/configure --prefix="$prefix" --target=$target --host=$target ${config_options_libstd} --enable-cxx-flags="$cxxflags"
make -j$(nproc)
make install

cd ..
