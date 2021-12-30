#! /usr/bin/env bash
set -euo pipefail

if ! command -v pdflatex > /dev/null 2>&1; then
  echo -e "\033[0;32mpdflatex is not installed, installing...\033[0m"
  brew install basictex
  eval "$(/usr/libexec/path_helper)"
  sudo tlmgr update --self
fi

relsize_installed="sudo tlmgr info relsize --json | jq -r '.[].installed'"
footmisc_installed="$(sudo tlmgr info footmisc --json | jq -r '.[].installed')"

if [ "$relsize_installed" == "false" ]; then
  echo -e "\033[0;32mCTAN package relsize is not installed, installing...\033[0m"
  sudo tlmgr install relsize
fi

if [ "$footmisc_installed" == "false" ]; then
  echo -e "\033[0;32mCTAN package footmisc is not installed, installing...\033[0m"
  sudo tlmgr install footmisc
fi
