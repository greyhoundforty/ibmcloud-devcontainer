set -e
export SHELLOPTS

apt-get update

apt-get install -y locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

echo ">> Installing base dependencies..."
apt-get install -y \
  apt-transport-https \
  build-essential \
  curl \
  git \
  grep \
  jq \

# Terraform
echo ">> Installing TFSwitch"
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# Kubernetes
echo ">> Installing kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl --retry 10 --retry-delay 5 -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
mv kubectl /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

# Helm
echo ">> Installing helm 3"
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# OpenShift CLI
echo ">> Installing OpenShift"
curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz
tar zxvf openshift-client-linux.tar.gz
mv oc /usr/local/bin/oc
rm -rf README.md kubectl openshift-client-linux.tar.gz

# Enable GIT for all directories to avoid prompt like `fatal: unsafe repository ('/app' is owned by someone else)`
git config --global --add safe.directory '*'

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

# Test snap install
snap install --edge starship

# Clean up
rm -rf /var/cache/apk/*
