#!/bin/bash
#
# Author:  Andres Lucas Garcia Fiorini
# Date: 01/24/2017
# Altoros S.A.(Argentina)
#set -x
/bin/ls -ltr
/bin/ls -ltr cf-manifest
/bin/ls -ltr cf-manifest-rsrc
echo "##############################"
#export
echo "##############################"

yes admin | bosh target $BOSH_TARGET
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh target error"
     exit 249;
fi

bosh deployment cf-manifest-rsrc/minimal-aws-salida.yml
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh deployment error"
     exit 248;
fi
bosh upload stemcell --skip-if-exists https://s3.amazonaws.com/bosh-aws-light-stemcells/light-bosh-stemcell-3312.15-aws-xen-hvm-ubuntu-trusty-go_agent.tgz

bosh create release --skip-if-exists 
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh create release error"
     exit 247;
fi
bosh upload release --skip-if-exists
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 246;     
fi
# bosh deploy
