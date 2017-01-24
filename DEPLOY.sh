#!/bin/bash
#
# Author:  Andres Lucas Garcia Fiorini
# Date: 01/24/2017
# Altoros S.A.(Argentina)
set -x
/bin/ls -ltr
echo "##############################"
export
rvm
rvm list
echo "##############################"

bosh target $BOSH_TARGET
bosh deployment cf-manifest/minimal-aws-salida.yml
bosh upload stemcell https://s3.amazonaws.com/bosh-aws-light-stemcells/light-bosh-stemcell-3312.15-aws-xen-hvm-ubuntu-trusty-go_agent.tgz
bosh create release
bosh upload release
# bosh deploy
