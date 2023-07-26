#!/usr/bin/env bash

set -e
set -u
set -o pipefail

git clone --branch=main --depth=1 https://github.com/greyhoundforty/tycho-devbox.git
mv tycho-devbox/.devcontainer .devcontainer
rm -rf tycho-devbox
