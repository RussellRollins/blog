#!/bin/bash
set -euo pipefail

# No matter where we call the script from, execute in root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$DIR"

./script/install-hugo.sh
./script/install-tex.sh

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo -e "\033[0;32mHugo build...\033[0m"
cd russellrollins
  hugo --destination="${DIR}/public" --cleanDestinationDir
cd "$DIR"


echo -e "\033[0;32mLatex resume build...\033[0m"
cd resume
  pdflatex Resume --interaction errorstopmode
  mkdir -p ../public/assets
  mv Resume.pdf ../public/assets/resume.pdf
  rm Resume.log
  rm Resume.aux
cd "$DIR"

cd public
  git add .
  msg="rebuilding site `date`"
  if [ $# -eq 1 ]; then
    msg="$1"
  fi
  git commit -m "$msg"
  git push origin master
cd  "$DIR"
