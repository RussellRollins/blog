#!/bin/bash
set -euo pipefail

# No matter where we call the script from, execute in root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$DIR"

./script/install-hugo.sh
./script/install-tex.sh

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Ensure submodules are populated
git submodule update --init --recursive

# Make sure publish target is on master and current with remote
cd "${DIR}/russellrollins.github.io"
  git checkout master
  git pull --ff-only origin master
cd "$DIR"

echo -e "\033[0;32mHugo build...\033[0m"
# Clear submodule working tree, preserving .git pointer (Hugo's --cleanDestinationDir would wipe .git too)
find "${DIR}/russellrollins.github.io" -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +
cd russellrollins
  hugo --destination="${DIR}/russellrollins.github.io"
cd "$DIR"


echo -e "\033[0;32mLatex resume build...\033[0m"
cd resume
  pdflatex Resume --interaction errorstopmode >/dev/null 2>&1
  mkdir -p "../russellrollins.github.io/assets"
  mv Resume.pdf ../russellrollins.github.io/assets/resume.pdf
  rm Resume.log
  rm Resume.aux
cd "$DIR"

echo -e "\033[0;32mHacking favicon...\033[0m"
cp russellrollins/static/favicon.ico russellrollins.github.io/favicon.ico

echo -e "\033[0;32mHacking CNAME...\033[0m"
cp russellrollins/assets/CNAME russellrollins.github.io/CNAME

cd "russellrollins.github.io"
  git add .
  msg="rebuilding site $(date)"
  if [ $# -eq 1 ]; then
    msg="$1"
  fi
  git commit -m "$msg"
  git push origin master
cd  "$DIR"
