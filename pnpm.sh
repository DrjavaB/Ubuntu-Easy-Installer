#!/bin/bash
sh <(curl -fSL https://get.pnpm.io/install.sh)
corepack enable

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
source $HOME/.zshrc

