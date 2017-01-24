#!/bin/bash
#
# Author:  Andres Lucas Garcia Fiorini
# Date: 01/24/2017
# Altoros S.A.(Argentina)

/bin/ls -ltr
bosh status
BOSH_W=`/usr/bin/whereis bosh`

$BOSH_W deployment cf-manifest/minimal-aws-salida.yml
$BOSH_W upload stemcell https://s3.amazonaws.com/bosh-aws-light-stemcells/light-bosh-stemcell-3312.15-aws-xen-hvm-ubuntu-trusty-go_agent.tgz
$BOSH_W create release
$BOSH_W upload release

