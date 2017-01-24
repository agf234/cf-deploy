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
set -x
bosh deployment cf-manifest-rsrc/minimal-aws-salida.yml
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh deployment error"
     exit 248;
fi
bosh upload stemcell --skip-if-exists https://s3.amazonaws.com/bosh-aws-light-stemcells/light-bosh-stemcell-3312.15-aws-xen-hvm-ubuntu-trusty-go_agent.tgz

bosh upload release https://bosh.io/d/github.com/cloudfoundry/cf-release
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 247;
fi
bosh upload release https://bosh.io/d/github.com/cloudfoundry/diego-release
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 247;
fi
bosh upload release https://bosh.io/d/github.com/cloudfoundry/cflinuxfs2-rootfs-release
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 247;
fi
bosh upload release https://bosh.io/d/github.com/cloudfoundry/garden-runc-release
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 247;
fi
bosh upload release https://bosh.io/d/github.com/cloudfoundry-incubator/etcd-release
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh upload release error"
     exit 247;
fi

yes yes | bosh deploy
if [ $? != 0 ];
then
     echo "##############################"
     echo "bosh deploy error"
     bosh task
     bosh tasks
     bosh task --debug
     bosh cck cf  --auto
     #yes yes | bosh delete deployment cf
     exit 247;
fi
