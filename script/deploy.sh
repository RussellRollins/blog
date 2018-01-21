#!/bin/bash
set -euo pipefail

# No matter where we call the script from, execute if from the repo root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$DIR/.."
  echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

  echo -e "\033[0;32mHugo build...\033[0m"
  hugo

  echo -e "\033[0;32mLatex resume build...\033[0m"
  # do stuff


  pushd public
    git add .
    msg="rebuilding site `date`"
    if [ $# -eq 1 ]; then
      msg="$1"
    fi
    git commit -m "$msg"
    git push origin master
  popd
popd


