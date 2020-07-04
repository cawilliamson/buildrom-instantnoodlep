#!/usr/bin/env bash

lunch derp_instantnoodlep-userdebug
mka kronic -j"$(nproc --all)"
