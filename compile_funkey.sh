#!/bin/sh
#libmedia, gui/sdl
export PATH=/opt/funkey-toolchain/bin:$PATH
./configure --host=arm-linux CXXFLAGS="-Os -std=gnu++14" --with-pixelformat="RGB565" --with-statistics=no --with-security=no --disable-jemalloc --disable-swftree --disable-testsuite --disable-visibility --disable-visibility --disable-harden --disable-schemas-install --disable-extensions --enable-sound=sdl  --disable-doublebuf --enable-gui=sdl --enable-renderer=agg --enable-device=none --disable-glext --disable-kparts3 --disable-kparts4 --disable-npapi --disable-plugins --disable-menus --disable-swftree --disable-testsuite --disable-sa-launcher --without-gconf --enable-media=ffmpeg --with-sdl-incl="/opt/funkey-toolchain/arm-buildroot-linux-musleabihf/sysroot/usr/include/SDL" --enable-static --disable-shared --with-agg-incl="/opt/funkey-toolchain/arm-buildroot-linux-musleabihf/sysroot/usr/include/agg2" --with-curl-incl="/opt/funkey-toolchain/arm-buildroot-linux-musleabihf/sysroot/usr/include" --with-freetype-incl="/opt/funkey-toolchain/arm-buildroot-linux-musleabihf/sysroot/usr/include/freetype2" --with-ffmpeg-incl="/opt/funkey-toolchain/arm-buildroot-linux-musleabihf/sysroot/usr/include/libavcodec"
