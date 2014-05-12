#!/bin/bash

set -e

#export PACKER_LOG=1
rm packer_virtualbox_virtualbox.box || true
packer build -var-file ~/.rackspace-creds.json -only=virtualbox packer.json
vagrant box remove vagrant_machine || true
vagrant box add vagrant_machine packer_virtualbox_virtualbox.box

