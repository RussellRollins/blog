#! /usr/bin/env bash
set -euo pipefail


# No matter where we call the script from, execute in root dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$DIR"

./script/install-tex.sh

cd resume
  tmpdir="$(mktemp -d)"
  pdflatex Resume --interaction errorstopmode
  mv Resume.pdf "${tmpdir}/Resume.pdf" 
  rm Resume.log
  rm Resume.aux
  open "${tmpdir}/Resume.pdf"
cd "$DIR"
