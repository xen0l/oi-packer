#!/usr/bin/env bash

set -ex

BUILD_VERSION=$(date +%Y%m%d)
packer build -only=virtualbox-iso.oi-hipster -var "build_version=${BUILD_VERSION}" -parallel-builds=1 hipster.pkr.hcl

vagrant box add --name hipster-test-virtualbox "OI-hipster-${BUILD_VERSION}-virtualbox.box"
vagrant init hipster-test-virtualbox
vagrant up
echo "Please test this box and disconnect once done."
vagrant ssh
vagrant destroy
vagrant box remove hipster-test-virtualbox
rm Vagrantfile

packer build -only=qemu.oi-hipster -var "build_version=${BUILD_VERSION}" -parallel-builds=1 hipster.pkr.hcl

vagrant box add --name hipster-test-libvirt "OI-hipster-${BUILD_VERSION}-libvirt.box"
vagrant init hipster-test-libvirt
vagrant up --provider=libvirt
echo "Please test this box and disconnect once done."
vagrant ssh
vagrant destroy
vagrant box remove hipster-test-libvirt
rm Vagrantfile
