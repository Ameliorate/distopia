#!/usr/bin/env bash

DISTOPIA_PWD="$(dirname "$0")"
export DISTOPIA_PWD
make -C $DISTOPIA_PWD result
$DISTOPIA_PWD/result/bin/distopia $1
