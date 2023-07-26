#!/usr/bin/env bash

set -e
set -u
set -o pipefail

git clone --branch=main --depth=1 https://github.com/greyhoundforty/ibmcloud-devcontainer.git
mv ibmcloud-devcontainer/.devcontainer .devcontainer
rm -rf ibmcloud-devcontainer
