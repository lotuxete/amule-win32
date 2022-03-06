#!/usr/bin/bash

set -e

export BUILDDIR=$PWD/build-$TARGET

./scripts/zlib.sh
./scripts/cryptopp.sh
./scripts/libiconv.sh 
./scripts/gettext.sh
./scripts/boost.sh
./scripts/wxwidgets.sh
./scripts/geoip.sh
./scripts/libpng.sh 
./scripts/libupnp.sh 
./scripts/amule-2.3.3.sh
./scripts/amule-dlp.sh 