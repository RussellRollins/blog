#! /usr/bin/env bash
set -euo pipefail

# No matter where we call the script from, execute in root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$DIR"

./script/install-hugo.sh

cd "russellrollins"
open http://localhost:1313/
hugo server -D
