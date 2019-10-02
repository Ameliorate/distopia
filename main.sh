#!/usr/bin/env bash

DISTOPIA_PWD="$(dirname "$(readlink -f "$0")")"
export DISTOPIA_PWD
nix-shell $DISTOPIA_PWD/shell.nix --command "$DISTOPIA_PWD/src/main.pl $1"
