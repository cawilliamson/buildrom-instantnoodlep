#!/usr/bin/env bash
set +x

# declare env variables
ANDROID_JACK_VM_ARGS="-Xmx8g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
export ANDROID_JACK_VM_ARGS

# shellcheck source=/dev/null
source "/var/tmp/buildrom/tmp/includes/${DEVICE}/${ROM}/repos.sh"

# change dir
cd /usr/src/rom || exit

# set git config
git config --global color.ui false

# fetch android sources
repo init --depth=1 -u "${ROM_REPO}" -b "${ROM_BRANCH}"
mkdir -p .repo/local_manifests/
cp -v /var/tmp/buildrom/tmp/includes/"${DEVICE}"/"${ROM}"/local_manifest*.xml .repo/local_manifests/
repo sync -c -j"$(nproc --all)" --force-sync --no-clone-bundle --no-tags

# apply patches
for file in /var/tmp/buildrom/tmp/includes/"${DEVICE}"/"${ROM}"/*.patch; do
  patch -p1 --forward < "${file}" || true
done

# build rom
# shellcheck source=/dev/null
source build/envsetup.sh
# shellcheck source=/dev/null
source "/var/tmp/buildrom/tmp/includes/${DEVICE}/${ROM}/build.sh"

# copy output zip
rm -fv /usr/src/rom/out/target/product/instantnoodle*/*ota*.zip
mkdir -p /var/tmp/buildrom/out
cp -v /usr/src/rom/out/target/product/instantnoodle*/*.zip /var/tmp/buildrom/out
