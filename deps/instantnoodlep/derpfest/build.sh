#!/usr/bin/env bash

lunch aosp_instantnoodlep-userdebug
mka kronic -j"$(nproc --all)"
