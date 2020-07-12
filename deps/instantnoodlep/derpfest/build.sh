#!/usr/bin/env bash

# hack to fix build error (missing smomo_interface.h)
rm -rf frameworks/native
git clone --depth=1 https://github.com/DerpFest-Sanders/platform_frameworks_native.git -b ten frameworks/native

lunch derp_instantnoodlep-userdebug
mka kronic -j"$(nproc --all)"
