# PPU toolchain

This repository contains build instructions for the PPU (Plasticity Processing Unit) toolchain.
It is the toplevel repository of the compiler/linker toolchain consisting of
* binutils-gdb: patched linker/assembler, gdb and object file helpers
* gcc: patched C, C++ compiler and libstdc++
* newlib: patched C library

## How to build

Clone the repositories:
```
binutils-gdb@binutils-2_25-branch-nux
gcc@nux-on-gcc-4_9_4-release
newlib@master
oppulance@master
```

Each repository contains numbered build scripts in
```
repo/ci/*.sh
```
which are to be executed in the repository order above and in ascending number order inside a
repository.

During build, a build folder will be created for each repository, namely
```
build_binutils
build_gcc
build_newlib
build_libstdc++
```
and an `install` folder for installation.

## Usage of local build

Prepend `PATH` with `install/bin` and `LD_LIBRARY_PATH` with `install/lib`.
For usage in singularity containers, `SINGULARITYENV_PREPEND_PATH` and `SINGULARITYENV_LD_LIBRARY_PATH`
are to be set in the same way.

## Usage once deployed

The toolchain is built and deployed by a continuous integration Jenkins job.
Is can be loaded via
```
	module load ppu-toolchain
```
on either a frontend or cluster nodes.

## Migrate from toolchain without operating system target (i.e. -eabi)

The operating system target is ppu and the architecture is powerpc, therefore the binaries will be
named like:
```
powerpc-ppu-gcc
powerpc-ppu-nm
```

For linking the toolchain with libc and libstdc++ using waf, the ordered list of `['stdc++', 'c', 'm', 'g', 'gcc']`
needs to be appended to `conf.env.STLIB` in the configure step of the wscript.
