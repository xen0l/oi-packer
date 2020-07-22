#!/usr/bin/env bash

set -ex

REPO="openindiana/hipster"
VERSION=$(date +%Y%m%d)
if [[ -n $1 ]]; then
  REPO=$1
fi

if [[ -n $2 ]]; then
  VERSION=$2
fi

vagrant cloud publish -r "${REPO}" "${VERSION}" libvirt "OI-hipster-${VERSION}-libvirt.box"
vagrant cloud publish -r "${REPO}" "${VERSION}" virtualbox "OI-hipster-${VERSION}-virtualbox.box"
