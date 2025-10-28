#!/bin/bash

set -xeo pipefail

apt-get install -y jq

# steal environment variables TAS_URL, TAS_PATH and BUNDLE_DOWNLOAD from https://github.com/EverestAPI/Everest/blob/dev/.github/tas-check/run-locally.sh
curl --fail https://raw.githubusercontent.com/EverestAPI/Everest/refs/heads/dev/.github/tas-check/run-locally.sh | grep -v ".sh" > /tmp/run-locally.sh
source /tmp/run-locally.sh StrawberryJam2021 dummy
rm /tmp/run-locally.sh

# steal CelesteTAS URL as well
CELESTETAS_URL=`curl --fail https://raw.githubusercontent.com/EverestAPI/Everest/refs/heads/dev/.github/tas-check/2-2-install-inner.sh | grep CelesteTAS.zip | sed -E 's/.*\"([^"]+)\".*/\1/'`

install_from_zip() {
	curl --fail -Lo t.zip "$1"
    unzip t.zip
    rm -v t.zip
}

# install TAS files
cd /home/ubuntu
install_from_zip "${TAS_URL}"

# install mods
cd celeste/Mods
curl --fail -Lo CelesteTAS.zip "${CELESTETAS_URL}"
install_from_zip "${BUNDLE_DOWNLOAD}"

# edit the run script to include the actual TAS path instead of an env variable
sed -i "s,\${TAS_PATH},${TAS_PATH}," /home/ubuntu/tas-check.sh