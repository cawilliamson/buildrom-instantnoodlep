#!/usr/bin/env bash

lunch aosip_instantnoodlep-userdebug
mka kronic -j"$(nproc --all)"
