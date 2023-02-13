#!/bin/bash
set -e
export SHELLOPTS

# IBM Cloud CLI
echo ">> Installing ibmcloud cli"
curl -fsSL https://clis.cloud.ibm.com/install/linux > /tmp/bxinstall.sh
sh /tmp/bxinstall.sh
rm /tmp/bxinstall.sh

# IBM Cloud CLI plugins
echo ">> Installing ibmcloud plugins"
ibmcloud_plugins=( \
  code-engine \
  cloud-databases \
  cloud-dns-services \
  cloud-functions \
  cloud-internet-services \
  cloud-object-storage \
  container-registry \
  container-service \
  vpc-infrastructure \
  schematics \
  tg \
)
for plugin in "${ibmcloud_plugins[@]}"
do
  ibmcloud plugin install $plugin -f -r "IBM Cloud"
done

ibmcloud config --check-version=false

rm -rf /root/.bluemix/tmp /tmp/*
