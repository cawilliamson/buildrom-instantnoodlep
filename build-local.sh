#!/usr/bin/env bash

if [ $# -ne 2 ]; then
  echo "You must provide two arguments: [ $(ls deps | grep -v common | tr '\n' ' ')] [ $(ls deps/instantnoodlep | grep -v common | tr '\n' ' ')]"
  exit 1
fi

if [ ! -d "deps/${1}/${2}" ]; then
  echo "Device and/or ROM configuration do not exist. Typo?"
  exit 1
fi

# generate includes dir
echo "[*] Generating includes dir"
mkdir -p tmp/includes/common tmp/includes/"${1}"/"${2}"/
cp -fv deps/common/* tmp/includes/common/
if [[ "${2}" != *"lineage"* ]]; then
  cp -fv deps/"${1}"/common/local_manifest_aosp.xml tmp/includes/"${1}"/"${2}"/
else
  cp -fv deps/"${1}"/common/local_manifest_lineage.xml tmp/includes/"${1}"/"${2}"/
fi
cp -fv deps/"${1}"/"${2}"/* tmp/includes/"${1}"/"${2}"/

# run docker build
echo "[*] Building docker container"
docker build -t chrisawcom/buildrom .

# docker run
echo "[*] Starting ROM build"
docker run --privileged --tty --rm -e DEVICE="${1}" -e ROM="${2}" -v "$(pwd)/tmp/src:/usr/src/rom" -v "$(pwd):/var/tmp/buildrom" -v "$(pwd)/out:/var/tmp/buildrom/out" chrisawcom/buildrom

# mount gdrive
#echo "[*] Mounting Google Drive"
#mkdir -p "${HOME}/Drive"
#google-drive-ocamlfuse "${HOME}/Drive"

# upload file to gdrive
#echo "[*] Uploading file to Google Drive"
#mv tmp/"${1}"/"${2}"/*.zip "${HOME}"/Drive/Public/ROMs/"${1}"/"${2}"/

# clean includes folder
rm -frv tmp/includes/"${1}"/"${2}"
