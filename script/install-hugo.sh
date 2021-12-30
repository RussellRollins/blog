#! /usr/bin/env bash
set -euo pipefail

HUGO_VERSION="0.91.2"

# No matter where we call the script from, execute in root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$DIR"

if ! command -v hugo > /dev/null 2>&1; then
  echo -e "\033[0;32mHugo is not installed, installing...\033[0m"

  # For now, only care about MacOS
  os="macOS"
  arch="64bit"
  if [ "$(uname -p)" == "arm" ]; then
    arch="ARM64"
  fi

  curl -sSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_${os}-${arch}.tar.gz" | \
    tar -xz -C ~/bin hugo 
fi
