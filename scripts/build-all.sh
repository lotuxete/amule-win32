#!/usr/bin/bash

set -e

help_msg="Usage: ./scripts/build-all.sh -arch=[x86/arm32] -cc=[gcc/clang]"

if [ $# == 2 ]
then
    for option in "$@"; do
        if [ $option == "-arch=x86" ]
        then 
            ARCH=win32
        elif [ $option == "-arch=arm32" ]
        then
            ARCH=win32-arm
        elif [ $option == "-cc=gcc" ]
        then
            USE_LLVM=no
        elif [ $option == "-cc=clang" ]
        then
            USE_LLVM=yes
        else
            echo $help_msg
            exit -1
        fi
    done
else
    echo $help_msg
    exit -1
fi


if [ "$USE_LLVM" == "yes" ]
then
    PATH=$PWD/toolchain/clang/bin/:$PATH
else
    PATH=$PWD/toolchain/mingw32/bin/:$PATH
fi

if [ "$ARCH" == "win32" ]
then
    TARGET=i686-w64-mingw32
elif [ "$ARCH" == "win32-arm" ]
then
    TARGET=armv7-w64-mingw32
fi

BUILDDIR=$PWD/build-$ARCH

[[ $(type -P "$TARGET-g++") ]] &&  echo "Using compiler $TARGET-g++"  || 
    { echo "$TARGET-g++ is not found or executable!" ; exit -2; }

export PATH
export TARGET
export BUILDDIR
export USE_LLVM
export ARCH

./scripts/zlib.sh
./scripts/libpng.sh 
./scripts/libiconv.sh 
./scripts/geoip.sh
./scripts/libupnp.sh 

if [ "$USE_LLVM" == "no" ]
then
    ./scripts/gettext.sh
fi

./scripts/cryptopp-autotools.sh
./scripts/wxwidgets.sh
./scripts/boost.sh
./scripts/amule-2.3.3.sh
./scripts/amule-dlp.sh 