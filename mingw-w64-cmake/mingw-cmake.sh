#!/bin/bash

. mingw-env @TRIPLE@

mingw_prefix=/usr/@TRIPLE@

export PATH="${mingw_prefix}/bin:$PATH"

case "$1" in
    -E|--build|--install|--open|--find-package|--help)
        exec cmake "$@"
        ;;
    *)
        exec cmake \
             -DCMAKE_INSTALL_PREFIX:PATH=${mingw_prefix} \
             -DCMAKE_INSTALL_LIBDIR:PATH=lib \
             -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${mingw_prefix}/include \
             -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${mingw_prefix}/include \
             -DBUILD_SHARED_LIBS:BOOL=ON \
             -DCMAKE_TOOLCHAIN_FILE=/usr/share/mingw/toolchain-@TRIPLE@.cmake \
             -DCMAKE_CROSSCOMPILING_EMULATOR=/usr/bin/@TRIPLE@-wine \
             "$@"
        ;;
esac
